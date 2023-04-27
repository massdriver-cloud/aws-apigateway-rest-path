resource "massdriver_artifact" "path" {
  field                = "path"
  provider_resource_id = local.resource_arn
  name                 = "API Gateway Path: ${var.md_metadata.name_prefix}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          arn = local.resource_arn
        }
      }
      specs = {
        aws = {
          region = local.region
        }
      }
    }
  )
}
