resource "aws_launch_configuration" "web_lc" {
  name                 = "web_lc"
  image_id             = var.web_amis[var.region]
  instance_type        = var.web_instance_type
  key_name             = aws_key_pair.web_key_pair.key_name
  user_data            = file("scripts/apache.sh")
  iam_instance_profile = aws_iam_instance_profile.s3_ec2_rofile.name
  security_groups      = [aws_security_group.web_sg.id]
}



resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 90
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.web_elb.name]
  launch_configuration      = aws_launch_configuration.web_lc.name
  vpc_zone_identifier       = local.public_subnets_ids

}


resource "aws_autoscaling_policy" "AddInstancePolicy" {
  name                   = "AddInstancePolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}


resource "aws_autoscaling_policy" "RemoveInstancePolicy" {
  name                   = "RemoveInstancePolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}



resource "aws_cloudwatch_metric_alarm" "avg_cpu_ge_80" {
  alarm_name          = "avg_cpu_ge_80"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.AddInstancePolicy.arn]
}



resource "aws_cloudwatch_metric_alarm" "avg_cpu_le_35" {
  alarm_name          = "avg_cpu_le_35"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "35"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.RemoveInstancePolicy.arn]
}