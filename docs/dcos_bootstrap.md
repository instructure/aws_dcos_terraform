
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
| build_script_path | the path to a custom build script for the bootstrap package | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| dcos_install_url |  |

