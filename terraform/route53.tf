resource "aws_route53_record" "app_dns" {
  zone_id = var.HostedZoneId                  # The ID of the Route 53 hosted zone (e.g., Z123456ABCDEF)
  name    = var.domain_name                  # The subdomain you want (or use "example.com" directly)
  type    = "A"

  alias {
    name                   = aws_lb.http_alb.dns_name      # ALB DNS name (e.g., my-lb-123456.eu-west-1.elb.amazonaws.com)
    zone_id                = aws_lb.http_alb.zone_id       # The hosted zone ID of the ALB (comes from the LB resource)
    evaluate_target_health = true
  }
}
