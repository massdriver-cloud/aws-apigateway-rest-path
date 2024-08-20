## AWS API Gateway REST Path

Amazon API Gateway is a managed service that allows developers to create and publish APIs at any scale. It acts as a "front door" for applications to access data, business logic, or functionality from backend services.

### Design Decisions

1. **Resource Naming**: The naming convention for the API Gateway REST paths follows a specific pattern to ensure consistency across the different environments (development, staging, production).
2. **Path Structure**: Paths are designed to be modular and reusable, making it easier to manage and update the APIs.
3. **Security**: Integration with AWS Identity and Access Management (IAM) and API keys functionality ensures that only authorized users can access the paths.
4. **Stages and Deployment**: Utilizes stages to manage different environments and deployments, allowing for controlled releases and easy rollback if necessary.
5. **Monitoring and Metrics**: Integration with CloudWatch to provide detailed metrics and logging for better monitoring and troubleshooting.

### Runbook

#### API Not Responding

If an API is not responding, you can use the AWS CLI to check the status and history of deployments.

To get the list of deployments:

```sh
aws apigateway get-deployments --rest-api-id <api_id>
```

You should expect a list of deployment details including `id`, `createdDate`, and description of each deployment.

#### Unauthorized Error

An unauthorized error usually indicates an issue with API Gateway resource policies or IAM roles.

To check the resource policy:

```sh
aws apigateway get-resource-policy --rest-api-id <api_id>
```

Inspect the policy to ensure that it allows access from your client.

#### Missing Methods or Resources

If a particular method or resource is missing, use the AWS CLI to list resources:

```sh
aws apigateway get-resources --rest-api-id <api_id>
```

This will return a list of all resources and methods within your API. Verify that the resource and methods you expect are present.

#### Debugging Lambda Integration

If your API is integrated with AWS Lambda and it's failing, you can check the logs for the Lambda function:

```sh
aws logs filter-log-events --log-group-name /aws/lambda/<function_name> --start-time <timestamp> --end-time <timestamp>
```

Logs will show invocation errors, which can help trace the issue.

#### Slow API Response

To troubleshoot performance issues, you can check CloudWatch metrics:

```sh
aws cloudwatch get-metric-statistics --namespace AWS/ApiGateway --metric-name Latency --start-time <start_time> --end-time <end_time> --period 60 --statistics Average --dimensions Name=ApiName,Value=<api_name>
```

This will provide average latency information which can help identify if certain endpoints or times of the day are causing bottlenecks.

