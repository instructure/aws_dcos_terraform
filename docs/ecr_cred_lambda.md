
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| env_name |  | - | yes |
| docker_cred_bucket | the bucket to write creds to | - | yes |
| docker_cred_key | by default, we write to /docker/{env_name}/creds.tar.gz, but you can set this and write to a different path in s3 | `""` | no |
| lambda_build_script | override script used to build and upload a lambda function | `""` | no |
| handler_name | then name of the handler, useful if you want to send in your own implementation | `"write_cred.handler"` | no |
| lambda_role | override the role to run the lambda under, you must take care of making sure the role can by assumed by lambda and also have the ability to get auth from ECR and write to s3 | `""` | no |
| num_hours_tick | how often to write the creds out | `4` | no |
| runtime | the runtime of the lambda function | `"nodejs4.3"` | no |
| registry_id | the registry_id is the account_id | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda_role_id |  |
| lambda_role_arn |  |
| lambda_role_name |  |
| lambda_arn |  |

