# aws-modules-cloudfront
Module for AWS Cloudfront distribution

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | List of extra CNAMEs (alternate domain names), if any, for this distribution | `list(string)` | `[]` | no |
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin | `list(string)` | n/a | yes |
| <a name="input_cache_policy_id"></a> [cache\_policy\_id](#input\_cache\_policy\_id) | The unique identifier of the cache policy that is attached to the cache behavior | `string` | `""` | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | Controls whether CloudFront caches the response to requests using the specified HTTP methods | `list(string)` | n/a | yes |
| <a name="input_cloudfront_tags"></a> [cloudfront\_tags](#input\_cloudfront\_tags) | Tags for the CloudFront distribution | `object({})` | `{}` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | Any comments you want to include about the distribution | `string` | `""` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | Whether you want CloudFront to automatically compress content for web requests that include `Accept-Encoding: gzip` in the request header | `bool` | `false` | no |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | One or more custom error response elements (multiples allowed) | <pre>list(object({<br>    error_code            = string<br>    error_caching_min_ttl = number<br>    response_code         = string<br>    response_page_path    = string<br>  }))</pre> | n/a | yes |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL | `string` | `""` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | n/a | `number` | `3600` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the distribution is enabled to accept end user requests for content | `bool` | `true` | no |
| <a name="input_field_level_encryption_id"></a> [field\_level\_encryption\_id](#input\_field\_level\_encryption\_id) | Field level encryption configuration ID | `string` | `""` | no |
| <a name="input_forwarded_values"></a> [forwarded\_values](#input\_forwarded\_values) | The forwarded values configuration that specifies how CloudFront handles query strings, cookies and headers (maximum one) | <pre>object({<br>    query_string            = bool<br>    headers                 = optional(list(string))<br>    query_string_cache_keys = optional(list(string))<br>    cookies = object({<br>      forward           = string<br>      whitelisted_names = optional(list(string))<br>    })<br>  })</pre> | <pre>{<br>  "cookies": {<br>    "forward": "none"<br>  },<br>  "query_string": false<br>}</pre> | no |
| <a name="input_function_association"></a> [function\_association](#input\_function\_association) | A config block that triggers a cloudfront function with specific actions (maximum 2) | <pre>list(object({<br>    event_type = string<br>    lambda_arn = string<br>  }))</pre> | `[]` | no |
| <a name="input_http_version"></a> [http\_version](#input\_http\_version) | The maximum HTTP version to support on the distribution | `string` | `"http2"` | no |
| <a name="input_is_ipv6_enabled"></a> [is\_ipv6\_enabled](#input\_is\_ipv6\_enabled) | Whether the IPv6 is enabled for the distribution | `bool` | `false` | no |
| <a name="input_lambda_function_association"></a> [lambda\_function\_association](#input\_lambda\_function\_association) | A config block that triggers a lambda function with specific actions (maximum 4) | <pre>list(object({<br>    event_type   = string<br>    lambda_arn   = string<br>    include_body = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | The logging configuration that controls how logs are written to your distribution (maximum one) | <pre>object({<br>    bucket          = string<br>    include_cookies = optional(bool)<br>    prefix          = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of `Cache-Control max-age`, `Cache-Control s-maxage`, and `Expires headers`. | `number` | `86400` | no |
| <a name="input_min_ttl"></a> [min\_ttl](#input\_min\_ttl) | The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated | `number` | `0` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0 | `list(any)` | `[]` | no |
| <a name="input_origin"></a> [origin](#input\_origin) | One or more origins for this distribution (multiples allowed) | <pre>list(object({<br>    domain_name         = string<br>    origin_id           = string<br>    connection_attempts = optional(number)<br>    connection_timeout  = optional(number)<br>    custom_header = optional(list(object({<br>      name  = string<br>      value = string<br>    })))<br>    custom_origin_config = optional(object({<br>      http_port                = number<br>      https_port               = number<br>      origin_protocol_policy   = string<br>      origin_ssl_protocols     = string<br>      origin_keepalive_timeout = optional(number)<br>      origin_read_timeout      = optional(number)<br>    }))<br>    origin_access_control_id = optional(string)<br>    origin_path              = optional(string)<br>    origin_shield = optional(object({<br>      enabled              = bool<br>      origin_shield_region = optional(string)<br>    }))<br>    s3_origin_config = optional(object({<br>      origin_access_identity = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_origin_group"></a> [origin\_group](#input\_origin\_group) | One or more origin\_group for this distribution (multiples allowed) | <pre>list(object({<br>    origin_id = string<br>    failover_criteria = object({<br>      status_codes = list(number)<br>    })<br>    member = list(object({<br>      origin_id = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for this distribution | `string` | `""` | no |
| <a name="input_realtime_log_config_arn"></a> [realtime\_log\_config\_arn](#input\_realtime\_log\_config\_arn) | The ARN of the real-time log configuration that is attached to this cache behavior | `string` | `""` | no |
| <a name="input_response_headers_policy_id"></a> [response\_headers\_policy\_id](#input\_response\_headers\_policy\_id) | The identifier for a response headers policy | `string` | `""` | no |
| <a name="input_restrictions"></a> [restrictions](#input\_restrictions) | The restriction configuration for this distribution (maximum one) | <pre>object({<br>    geo_restriction = object({<br>      locations        = list(string)<br>      restriction_type = string<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_retain_on_delete"></a> [retain\_on\_delete](#input\_retain\_on\_delete) | Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards | `bool` | `false` | no |
| <a name="input_target_origin_id"></a> [target\_origin\_id](#input\_target\_origin\_id) | The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior | `string` | n/a | yes |
| <a name="input_trusted_key_groups"></a> [trusted\_key\_groups](#input\_trusted\_key\_groups) | A list of key group IDs that CloudFront can use to validate signed URLs or signed cookies | `list(string)` | `[]` | no |
| <a name="input_trusted_signers"></a> [trusted\_signers](#input\_trusted\_signers) | List of AWS account IDs (or `self`) that you want to allow to create signed URLs for private content | `list(string)` | `[]` | no |
| <a name="input_viewer_certificate"></a> [viewer\_certificate](#input\_viewer\_certificate) | The SSL configuration for this distribution (maximum one). | <pre>object({<br>    acm_certificate_arn            = optional(string)<br>    cloudfront_default_certificate = optional(bool)<br>    iam_certificate_id             = optional(string)<br>    minimum_protocol_version       = optional(string)<br>    ssl_support_method             = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy) | Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern | `string` | n/a | yes |
| <a name="input_wait_for_deployment"></a> [wait\_for\_deployment](#input\_wait\_for\_deployment) | If enabled, the resource will wait for the distribution status to change from `InProgress` to `Deployed`. Setting this to `false` will skip the process | `bool` | `true` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
