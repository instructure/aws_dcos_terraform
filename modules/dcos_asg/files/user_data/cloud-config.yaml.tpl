#cloud-config
coreos:
  update:
    # ideally we don't want to do this, but we need to be a bit more careful with mesos
    reboot-strategy: "off"
  units:
    - name: |-
        format-var-lib-ephemeral.service
      command: |-
        start
      content: |
        [Unit]
        Description=AWS Setup: Formats the /var/lib ephemeral drive
        Before=var-lib.mount dbus.service
        [Service]
        Type=oneshot
        RemainAfterExit=yes
        ExecStart=/bin/bash -c "(blkid -t TYPE=ext4 | grep xvdb) || (/usr/sbin/mkfs.ext4 -F /dev/xvdb)"
    - name: |-
        var-lib.mount
      command: |-
        start
      content: |
        [Unit]
        Description=AWS Setup: Mount /var/lib
        Before=dbus.service
        [Mount]
        What=/dev/xvdb
        Where=/var/lib
        Type=ext4
    - name: |-
        dcos-boot-dl.service
      content: |
        [Unit]
        Description=Download start script
        After=network-online.target
        Wants=network-online.target
        [Service]
        Type=oneshot
        StandardOutput=journal+console
        StandardError=journal+console
        ExecStart=/usr/bin/curl -fLsSv --retry 20 -Y 100000 -y 60 -o /tmp/dcos_install.sh ${bootstrap_url}
    - name: |-
        dcos-start-install.service
      command: |-
        start
      content: |
        [Unit]
        Description=Run Install Script
        Requires=dcos-boot-dl.service
        After=dcos-boot-dl.service
        [Service]
        WorkingDirectory=/tmp
        Type=oneshot
        StandardOutput=journal+console
        StandardError=journal+console
        ExecStart=/bin/bash /tmp/dcos_install.sh ${role}
        [Install]
        WantedBy=multi-user.target
      enable: !!bool |-
        true
      no_block: !!bool |-
        true
