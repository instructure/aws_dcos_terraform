
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_id | the account in aws | string | - | yes |
| cluster_name |  | string | - | yes |
| docker_cred_bucket | bucket to write docker creds to | string | - | yes |
| namespace | the namespace for the repo | string | - | yes |
| push_principal | specify * for allowing all users to pull images | string | `` | no |
| repo_names | list of repo names, under the namespace | list | - | yes |
| users | a list of users to allow push access, if you won't want to whitelist specific users set to empty string ("") and set push_principal to * | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_role_arn |  |
| lambda_role_id |  |
| lambda_role_name |  |
| repo_names |  |

