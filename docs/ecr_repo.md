
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_id | the account in aws | string | - | yes |
| namespace | the namespace for the repo | string | - | yes |
| push_principal | allows for specifiy a wildcard of who can push | string | `` | no |
| repo_names | list of repo names, under the namespace | list | - | yes |
| users | a list of users to allow push access | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| repo_names |  |

