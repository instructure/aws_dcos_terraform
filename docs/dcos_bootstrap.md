
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket | the bucket to upload to | string | - | yes |
| build_script_path | the path to a custom build script for the bootstrap package | string | `` | no |
| cluster_name | the name of this cluster | string | - | yes |
| dcos_url | the dcos_generate_config.sh package to use, defaults to https://downloads.dcos.io/dcos/stable/${DCOS_VERSION}/dcos_generate_config.sh | string | `` | no |
| dcos_version | the version of DCOS to install, must be a stable released version (otherwise use dcos_url and arbitrary version here) | string | - | yes |
| finished_file |  | string | `__SUCCESS` | no |
| master_elb_dnsname |  | string | - | yes |
| num_masters | the number of masters | string | `3` | no |
| region |  | string | `us-east-1` | no |
| role_arn | a role to assume when uploading the file | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| dcos_install_path |  |

