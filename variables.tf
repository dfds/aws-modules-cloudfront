variable "aliases" {
  type        = list(string)
  description = "List of extra CNAMEs (alternate domain names), if any, for this distribution"
  default     = []
}

variable "allowed_methods" {
  type        = list(string)
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin"
}

variable "cached_methods" {
  type        = list(string)
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
}

variable "cache_policy_id" {
  type        = string
  description = "The unique identifier of the cache policy that is attached to the cache behavior"
  default     = ""
}

variable "comment" {
  type        = string
  description = "Any comments you want to include about the distribution"
  default     = ""
}

variable "compress" {
  type        = bool
  description = "Whether you want CloudFront to automatically compress content for web requests that include `Accept-Encoding: gzip` in the request header"
  default     = false
}

variable "custom_error_response" {
  type = list(object({
    error_code            = string
    error_caching_min_ttl = number
    response_code         = string
    response_page_path    = string
  }))
  description = "One or more custom error response elements (multiples allowed)"
  default     = []
}

variable "default_ttl" {
  type        = number
  description = ""
  default     = 3600
}

variable "default_root_object" {
  type        = string
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL"
  default     = ""
}

variable "enabled" {
  type        = bool
  description = "Whether the distribution is enabled to accept end user requests for content"
  default     = true
}

variable "field_level_encryption_id" {
  type        = string
  description = "Field level encryption configuration ID"
  default     = ""
}

variable "forwarded_values" {
  type = object({
    query_string            = bool
    headers                 = optional(list(string))
    query_string_cache_keys = optional(list(string))
    cookies = object({
      forward           = string
      whitelisted_names = optional(list(string))
    })
  })
  description = "The forwarded values configuration that specifies how CloudFront handles query strings, cookies and headers (maximum one)"
  default = {
    query_string = false
    cookies = {
      forward = "none"
    }
  }
}

variable "function_association" {
  type = list(object({
    event_type = string
    lambda_arn = string
  }))
  description = "A config block that triggers a cloudfront function with specific actions (maximum 2)"
  default     = []
  validation {
    condition     = length(var.function_association) <= 2
    error_message = "There can be a maximum 2 function_association blocks"
  }
}

variable "http_version" {
  type        = string
  description = "The maximum HTTP version to support on the distribution"
  default     = "http2"
  validation {
    condition     = contains(["http1.1", "http2", "http2and3", "http3"], var.http_version)
    error_message = "Allowed values for http_version are `http1.1`, `http2`, `http2and3` and `http3`."
  }
}

variable "is_ipv6_enabled" {
  type        = bool
  description = "Whether the IPv6 is enabled for the distribution"
  default     = false
}

variable "lambda_function_association" {
  type = list(object({
    event_type   = string
    lambda_arn   = string
    include_body = optional(bool)
  }))
  description = "A config block that triggers a lambda function with specific actions (maximum 4)"
  default     = []
  validation {
    condition     = length(var.lambda_function_association) <= 4
    error_message = "There can be a maximum 4 lambda_function_association blocks"
  }
}

variable "logging_config" {
  type = object({
    bucket          = string
    include_cookies = optional(bool)
    prefix          = optional(string)
  })
  description = "The logging configuration that controls how logs are written to your distribution (maximum one)"
}

variable "max_ttl" {
  type        = number
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of `Cache-Control max-age`, `Cache-Control s-maxage`, and `Expires headers`."
  default     = 86400
}

variable "min_ttl" {
  type        = number
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated"
  default     = 0
}

variable "ordered_cache_behavior" {
  type        = list(any)
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0"
  default     = []
}

variable "origin" {
  type = list(object({
    domain_name         = string
    origin_id           = string
    connection_attempts = optional(number)
    connection_timeout  = optional(number)
    custom_header = optional(list(object({
      name  = optional(string)
      value = optional(string)
    })))
    custom_origin_config = optional(object({
      http_port                = optional(number)
      https_port               = optional(number)
      origin_protocol_policy   = optional(string)
      origin_ssl_protocols     = optional(string)
      origin_keepalive_timeout = optional(number)
      origin_read_timeout      = optional(number)
    }))
    origin_access_control_id = optional(string)
    origin_path              = optional(string)
    origin_shield = optional(object({
      enabled              = optional(bool)
      origin_shield_region = optional(string)
    }))
    s3_origin_config = optional(object({
      origin_access_identity = string
    }))
  }))
  description = "One or more origins for this distribution (multiples allowed)"
}

variable "origin_group" {
  type = list(object({
    origin_id = string
    failover_criteria = object({
      status_codes = list(number)
    })
    member = list(object({
      origin_id = string
    }))
  }))
  description = "One or more origin_group for this distribution (multiples allowed)"
  default     = []
}

variable "price_class" {
  type        = string
  description = "The price class for this distribution"
  default     = "PriceClass_100"
}

variable "realtime_log_config_arn" {
  type        = string
  description = "The ARN of the real-time log configuration that is attached to this cache behavior"
  default     = ""
}

variable "response_headers_policy_id" {
  type        = string
  description = "The identifier for a response headers policy"
  default     = ""
}

variable "restrictions" {
  type = object({
    geo_restriction = object({
      locations        = list(string)
      restriction_type = string
    })
  })
  description = "The restriction configuration for this distribution (maximum one)"
}

variable "retain_on_delete" {
  type        = bool
  description = "Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards"
  default     = false
}

variable "tags" {
  type        = object({})
  description = "Tags for the CloudFront distribution"
  default     = {}
}

variable "target_origin_id" {
  type        = string
  description = "The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior"
}

variable "trusted_key_groups" {
  type        = list(string)
  description = "A list of key group IDs that CloudFront can use to validate signed URLs or signed cookies"
  default     = []
}

variable "trusted_signers" {
  type        = list(string)
  description = "List of AWS account IDs (or `self`) that you want to allow to create signed URLs for private content"
  default     = []
}

variable "viewer_certificate" {
  type = object({
    acm_certificate_arn            = optional(string)
    cloudfront_default_certificate = optional(bool)
    iam_certificate_id             = optional(string)
    minimum_protocol_version       = optional(string)
    ssl_support_method             = optional(string)
  })
  description = "The SSL configuration for this distribution (maximum one)."
  default     = {}
}

variable "viewer_protocol_policy" {
  type        = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern"
  validation {
    condition     = contains(["allow-all", "https-only", "redirect-to-https"], var.viewer_protocol_policy)
    error_message = "The value for viewer control policy should be `allow-all`, `https-only` or `redirect-to-https`."
  }
}

variable "wait_for_deployment" {
  type        = bool
  description = "If enabled, the resource will wait for the distribution status to change from `InProgress` to `Deployed`. Setting this to `false` will skip the process"
  default     = true
}

variable "web_acl_id" {
  type        = string
  description = "A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution"
  default     = ""
}
