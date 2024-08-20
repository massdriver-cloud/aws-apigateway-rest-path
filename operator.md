## AWS API Gateway REST Paths

AWS API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs. With API Gateway, you can create RESTful APIs to enable real-time two-way communication applications. This module is specifically designed for creating and managing REST API paths, offering a streamlined approach to setting up routes and integrating with backend services.

### Design Decisions

1. **Modular Design**: Each path is independently managed, allowing for granular updates and modifications without affecting the entire API.
2. **Security Focus**: Integration with AWS IAM roles and policies to ensure secure access and operations.
3. **Flexibility**: Configurable options for HTTP methods, request/response models, and integration types to cater to various application requirements.
4. **Simplified Management**: Easy-to-use structures for defining resource paths and their methods to encourage consistent API development practices across the team.

### Runbook

#### Unable to Access API Gateway Resource

You might encounter issues accessing the API Gateway resources due to incorrect permissions or misconfigured paths. To troubleshoot:

Check the resource status:

```sh
aws apigateway get-resources --rest-api-id <rest_api_id>
```

Replace `<rest_api_id>` with your actual API ID. This will list all the resources and their current state.

#### API Gateway Returns 403 Forbidden Error

This issue usually occurs due to permission settings or missing IAM policies.

Check the IAM role associated with your API Gateway:

```sh
aws iam get-role --role-name <role_name>
```

Replace `<role_name>` with your actual IAM role name. Review the attached policies to ensure they have the necessary permissions.

#### Invalid Request Response from Integration Backend

If the API Gateway returns an invalid response error from the backend integration, verify the request and response models:

Inspect the integration request response:

```sh
aws apigateway get-integration-response --rest-api-id <rest_api_id> --resource-id <resource_id> --http-method <http_method> --status-code <status_code>
```

Replace `<rest_api_id>`, `<resource_id>`, `<http_method>`, and `<status_code>` with their respective values. This will provide details about the integration response to identify any discrepancies.

#### Backend Service Connection Issues

For instance, if your API Gateway integrates with an AWS Lambda function, ensure the function is available and correctly configured.

List all Lambda functions:

```sh
aws lambda list-functions
```

Check the specific Lambda function details:

```sh
aws lambda get-function --function-name <function_name>
```

Replace `<function_name>` with your actual Lambda function name. Ensure the function configuration matches the expected settings for your API Gateway integration.

#### Verify API Endpoint Responses

If endpoint responses are not as expected, use the Curl command to manually test the endpoint and inspect headers and payloads for debugging.

```sh
curl -i -X GET https://<api_gateway_endpoint>/<resource_path>
```

Replace `<api_gateway_endpoint>` and `<resource_path>` with your actual endpoint URL and resource path. Check the returned HTTP status codes and payload for any issues.

These commands should help you effectively troubleshoot common issues related to your AWS API Gateway REST paths.

