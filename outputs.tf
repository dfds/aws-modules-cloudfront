output "domain_name" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "Domain name"
}

output "cloudfront_arn" {
  value       = aws_cloudfront_distribution.this.arn
  description = "ARN of the cloudfront distribution"
}