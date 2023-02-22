resource "aws_cloudfront_distribution" "this" {
  aliases = var.aliases
  comment = var.comment

  dynamic "custom_error_response" {
    for_each = var.custom_error_response

    content {
      error_code            = custom_error_response.value.error_code
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      response_code         = lookup(custom_error_response.value, "response_code", "")
      response_page_path    = lookup(custom_error_response.value, "response_page_path", "")
    }
  }

  default_cache_behavior {
    allowed_methods           = var.allowed_methods
    cached_methods            = var.cached_methods
    cache_policy_id           = var.cache_policy_id
    compress                  = var.compress
    field_level_encryption_id = var.field_level_encryption_id

    dynamic "forwarded_values" {
      for_each = length(var.forwarded_values) > 0 ? ["OK"] : []
      content {
        query_string            = lookup(var.forwarded_values, "query_string", false)
        headers                 = lookup(var.forwarded_values, "headers", [])
        query_string_cache_keys = lookup(var.forwarded_values, "query_string_cache_keys", [])
        cookies {
          forward           = lookup(var.forwarded_values.cookies, "forward", "none")
          whitelisted_names = lookup(var.forwarded_values.cookies, "whitelisted_names", [])
        }
      }
    }

    dynamic "lambda_function_association" {
      for_each = var.lambda_function_association
      iterator = i

      content {
        event_type   = i.value.event_type
        lambda_arn   = i.value.lambda_arn
        include_body = i.value.include_body
      }
    }

    dynamic "function_association" {
      for_each = var.function_association
      iterator = i

      content {
        event_type   = i.value.event_type
        function_arn = i.value.function_arn
      }
    }

    realtime_log_config_arn    = var.realtime_log_config_arn
    response_headers_policy_id = var.response_headers_policy_id
    target_origin_id           = var.target_origin_id
    trusted_key_groups         = var.trusted_key_groups
    trusted_signers            = var.trusted_signers
    viewer_protocol_policy     = var.viewer_protocol_policy

    min_ttl     = var.min_ttl
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  default_root_object = var.default_root_object
  enabled             = var.enabled
  http_version        = var.http_version
  is_ipv6_enabled     = var.is_ipv6_enabled

  dynamic "logging_config" {
    for_each = length(keys(var.logging_config)) != 0 ? [var.logging_config] : []

    content {
      bucket          = logging_config.value["bucket"]
      include_cookies = lookup(logging_config.value, "include_cookies", null)
      prefix          = lookup(logging_config.value, "prefix", "")
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = length(var.ordered_cache_behavior) != 0 ? [var.ordered_cache_behavior] : []
    iterator = i

    content {
      allowed_methods           = i.value.allowed_methods
      cached_methods            = i.value.cached_methods
      cache_policy_id           = lookup(i.value, "cache_policy_id", "")
      compress                  = lookup(i.value, "compress", false)
      default_ttl               = lookup(i.value, "default_ttl", null)
      field_level_encryption_id = lookup(i.value, "field_level_encryption_id", "")

      dynamic "forwarded_values" {
        for_each = contains(i.value, "forwarded_values") ? [i.value.forwarded_values] : []
        iterator = l

        content {
          cookies {
            forward           = l.value.cookies.forward
            whitelisted_names = lookup(l.value.cookies, "whitelisted_names", [])
          }
          headers                 = lookup(l.value, "headers", [])
          query_string            = l.value.query_string
          query_string_cache_keys = lookup(l.value, "query_string_cache_keys", [])
        }
      }

      dynamic "lambda_function_association" {
        for_each = contains(i.value, "lambda_function_association") ? [i.value.lambda_function_association] : []
        iterator = l

        content {
          event_type   = l.value.event_type
          lambda_arn   = l.value.lambda_arn
          include_body = lookup(l.value, "include_body", false)
        }
      }

      dynamic "function_association" {
        for_each = contains(i.value, "function_association") ? [i.value.function_association] : []
        iterator = f

        content {
          event_type   = f.value.event_type
          function_arn = f.value.function_arn
        }
      }

      max_ttl                    = lookup(i.value, "max_ttl", null)
      min_ttl                    = lookup(i.value, "min_ttl", 0)
      origin_request_policy_id   = lookup(i.value, "")
      path_pattern               = i.value.path_pattern
      realtime_log_config_arn    = lookup(i.value, "realtime_log_config_arn", "")
      response_headers_policy_id = lookup(i.value, "response_headers_policy_id", "")
      smooth_streaming           = lookup(i.value, "smooth_streaming", null)
      target_origin_id           = i.value.target_origin_id
      trusted_key_groups         = lookup(i.value, "trusted_key_groups", [])
      trusted_signers            = lookup(i.value, "trusted_signers", [])
      viewer_protocol_policy     = i.value.viewer_protocol_policy
    }
  }

  dynamic "origin" {
    for_each = var.origin

    content {
      domain_name         = origin.value.domain_name
      origin_id           = origin.value.origin_id
      connection_attempts = lookup(origin.value, "connection_attempts", null)
      connection_timeout  = lookup(origin.value, "connection_timeout", null)

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_header", []) != null ? [lookup(origin.value, "custom_header")] : []

        content {
          name  = lookup(custom_header.value, "name")
          value = lookup(custom_header.value, "value")
        }
      }
      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config", {}) != null ? [lookup(origin.value, "custom_origin_config")] : []

        content {
          http_port                = lookup(custom_origin_config.value, "http_port")
          https_port               = lookup(custom_origin_config.value, "https_port")
          origin_protocol_policy   = lookup(custom_origin_config.value, "origin_protocol_policy")
          origin_ssl_protocols     = lookup(custom_origin_config.value, "origin_ssl_protocols")
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout")
          origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout")
        }
      }

      origin_access_control_id = lookup(origin.value, "origin_access_control_id", "")
      origin_path              = lookup(origin.value, "origin_path", "")

      dynamic "origin_shield" {
        for_each = lookup(origin.value, "origin_shield") != null ? [lookup(origin.value, "origin_shield")] : []

        content {
          enabled              = lookup(origin_shield.value, "enabled")
          origin_shield_region = lookup(origin_shield.value, "origin_shield_region")
        }
      }

      dynamic "s3_origin_config" {
        for_each = lookup(origin.value, "s3_origin_config") != null ? [lookup(origin.value, "s3_origin_config")] : []

        content {
          origin_access_identity = lookup(s3_origin_config.value, "origin_access_identity")
        }
      }
    }
  }

  dynamic "origin_group" {
    for_each = length(var.origin_group) != 0 ? [var.origin_group] : []

    content {
      origin_id = origin_group.value.origin_id

      failover_criteria {
        status_codes = origin_group.value.failover_criteria.status_codes
      }

      dynamic "member" {
        for_each = origin_group.value.member

        content {
          origin_id = origin_group.value.member.origin_id
        }
      }
    }
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restrictions.geo_restriction.restriction_type
      locations        = var.restrictions.geo_restriction.locations
    }
  }
  viewer_certificate {
    acm_certificate_arn            = lookup(var.viewer_certificate, "acm_certificate_arn", "")
    cloudfront_default_certificate = lookup(var.viewer_certificate, "cloudfront_default_certificate", false)
    iam_certificate_id             = lookup(var.viewer_certificate, "iam_certificate_id", "")
    minimum_protocol_version       = lookup(var.viewer_certificate, "minimum_protocol_version", "TLSv1.2_2021")
    ssl_support_method             = lookup(var.viewer_certificate, "ssl_support_method", "")
  }

  web_acl_id          = var.web_acl_id
  retain_on_delete    = var.retain_on_delete
  wait_for_deployment = var.wait_for_deployment

  tags = var.tags
}