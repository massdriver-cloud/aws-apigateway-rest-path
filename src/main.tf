locals {
  is_a_root_resource = try(var.parent_path.data.infrastructure.arn, false) == false ? true : false
  region             = local.is_a_root_resource ? try(var.api_gateway.specs.aws.region, null) : try(var.parent_path.specs.aws.region, null)
  api_id             = local.is_a_root_resource ? try(split("/", var.api_gateway.data.infrastructure.arn)[2], null) : try(split("/", var.parent_path.data.infrastructure.arn)[2], null)
  parent_id          = local.is_a_root_resource ? try(var.api_gateway.data.infrastructure.root_resource_id, null) : try(split("/", var.parent_path.data.infrastructure.arn)[4], null)
  resource_arn       = "arn:aws:apigateway:${local.region}::/restapis/${local.api_id}/resources/${aws_api_gateway_resource.main.id}"
}

data "aws_caller_identity" "current" {}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = local.api_id
  parent_id   = local.parent_id
  path_part   = var.path
}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = local.api_id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = var.http_method
  authorization = "NONE"
}
