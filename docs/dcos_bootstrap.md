
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_region |  | `"us-east-1"` | no |
| master_elb_dns |  | - | yes |
| env_name |  | - | yes |
| exhibitor_bucket |  | - | yes |
| bootstrap_bucket |  | - | yes |
| bootstrap_dl_file |  | `"dcos_install.sh"` | no |
| finished_file |  | `"__SUCCESS"` | no |
| version | A version number of your cluster, bump this if you want to force an upgrade | `"1"` | no |
| dcos_url | the dcos_generate_config.sh package to use, defaults to https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh, which will be latest dcos version | `"https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh"` | no |
| build_script_path | the path to a custom build script for the bootstrap package | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| dcos_install_url |  |

