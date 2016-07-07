
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| namespace | the namespace for the repo | - | yes |
| repo_names | comma seperated list of repo names, under the namespace | - | yes |
| account_id | the account in aws | - | yes |
| users | a comma seperated list of users to allow push access | - | yes |
| push_principal | allows for specifiy a wildcard of who can push | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| repo_names |  |

