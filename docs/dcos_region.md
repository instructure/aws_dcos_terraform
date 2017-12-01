
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| endpoint_id | an existing vpc s3 endpoint to use, disables creating a vpc endpoint | string | `` | no |
| name | a name to specify your dcos env, should be something unique! | string | - | yes |
| region |  | string | `us-east-1` | no |
| route_table_ids | the route tables to place the s3 private endpoint | list | - | yes |
| vpc_id |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket |  |

