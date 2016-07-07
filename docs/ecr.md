
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| env_name |  | - | yes |
| docker_cred_bucket | bucket to write docker creds to | - | yes |
| namespace | the namespace for the repo | - | yes |
| repo_names | comma seperated list of repo names, under the namespace | - | yes |
| account_id | the account in aws | - | yes |
| users | a comma seperated list of users to allow push access, if you won't want to whitelist specific users set to empty string ("") and set push_principal to * | - | yes |
| push_principal | specify * for allowing all users to pull images | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_role_id |  |
| lambda_role_arn |  |
| lambda_role_name |  |
| lambda_arn |  |
| repo_names |  |

