#cloud-config
manage_etc_hosts: "localhost"
coreos:
  update:
    # ideally we don't want to do this, but we need to be a bit more careful with mesos
    reboot-strategy: "off"
  units:
    - name: format-var-lib-ephemeral.service
      command: start
      content: |
        [Unit]
        Description=AWS Setup: Formats the /var/lib ephemeral drive
        Wants=dev-xvdb.device
        Before=var-lib.mount
        Before=dbus.service
        [Service]
        Type=oneshot
        RemainAfterExit=yes
        Restart=no
        ExecStart=/bin/bash -c "(blkid -t TYPE=ext4 | grep xvdb) || (/usr/sbin/mkfs.ext4 -F /dev/xvdb)"
    - name: var-lib.mount
      command: start
      content: |
        [Unit]
        Description=AWS Setup: Mount /var/lib
        Requires=format-var-lib-ephemeral.service
        After=format-var-lib-ephemeral.service
        Before=dbus.service
        [Mount]
        What=/dev/xvdb
        Where=/var/lib
        Type=ext4
    - name: dcos-boot-download.service
      content: |
        [Unit]
        Description=Download start script
        After=network-online.target
        Wants=network-online.target
        [Service]
        Type=oneshot
        StandardOutput=journal+console
        StandardError=journal+console
        ExecStartPre=/usr/bin/mkdir -p /tmp/dcos_bootstrap
        ExecStart=/bin/docker run -v /tmp/dcos_bootstrap:/tmp/dcos_bootstrap garland/aws-cli-docker aws s3 sync ${dcos_install_path} /tmp/dcos_bootstrap
    - name: dcos-start-install.service
      command: start
      content: |
        [Unit]
        Description=Run Install Script
        Requires=dcos-boot-download.service
        After=dcos-boot-download.service
        [Service]
        WorkingDirectory=/tmp/dcos_bootstrap
        Type=oneshot
        StandardOutput=journal+console
        StandardError=journal+console
        ExecStart=/bin/bash /tmp/dcos_bootstrap/dcos_install.sh ${role}
        [Install]
        WantedBy=multi-user.target
    - name: dcos-set-attributes.service
      command: start
      content: |
        [Unit]
        Description=Add some node attributes
        Before=dcos-mesos-slave.service
        After=dcos-start-install.service
        ConditionPathExists=!/var/lib/dcos/mesos-slave-common
        [Service]
        Type=oneshot
        StandardOutput=journal+console
        StandardError=journal+console
        ExecStartPre=/usr/bin/mkdir -p /var/lib/dcos
        ExecStart=/bin/bash -c "ZONE=$(curl -L http://169.254.169.254/latest/meta-data/placement/availability-zone); echo \"MESOS_ATTRIBUTES=availability_zone:$ZONE\" >> /var/lib/dcos/mesos-slave-common"
        [Install]
        WantedBy=multi-user.target
      enable: true
      no_block: true
    - name: dcos-run-ssm.service
      command: start
      content: |
        [Unit]
        Description=Run the SSM Agent
        Requires=docker.service
        After=dcos-start-install.service
        After=docker.service
        [Service]
        StandardOutput=journal+console
        StandardError=journal+console
        Restart=always
        RestartSec=30
        ExecStart=/usr/bin/docker run --network=host -v /var/run/dbus:/var/run/dbus -v /run/systemd:/run/systemd crewton/amazon-ssm-agent:latest
        [Install]
        WantedBy=multi-user.target
      enable: true
      no_block: true
