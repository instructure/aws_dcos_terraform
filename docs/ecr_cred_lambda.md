
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name |  | string | - | yes |
| docker_cred_bucket | the bucket to write creds to | string | - | yes |
| docker_cred_key | by default, we write to ${cluster_name}/docker/creds.tar.gz, but you can set this and write to a different path in s3 | string | `` | no |
| handler_name | then name of the handler, useful if you want to send in your own implementation | string | `write_cred.handler` | no |
| lambda_build_script | override script used to build and upload a lambda function | string | `` | no |
| lambda_role | override the role to run the lambda under, you must take care of making sure the role can by assumed by lambda and also have the ability to get auth from ECR and write to s3 | string | `` | no |
| num_hours_tick | how often to write the creds out | string | `4` | no |
| registry_id | the registry_id is the account_id | string | - | yes |
| runtime | the runtime of the lambda function | string | `nodejs6.10` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_role_arn |  |
| lambda_role_id |  |
| lambda_role_name |  |

