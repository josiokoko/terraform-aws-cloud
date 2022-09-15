data "aws_route53_zone" "app_home" {
  name         = "onyxquityconsulting.com"
  private_zone = false
}


resource "aws_route53_record" "app_home" {
  zone_id = data.aws_route53_zone.app_home.zone_id
  name    = data.aws_route53_zone.app_home.name
  type    = "A"

  alias {
    name                   = aws_elb.web_elb.dns_name
    zone_id                = aws_elb.web_elb.zone_id
    evaluate_target_health = false
  }
}