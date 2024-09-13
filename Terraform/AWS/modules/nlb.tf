resource "aws_lb" "nlb_lambda" {
  name               = "${var.env}-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = module.vpc.private_subnets
  enable_deletion_protection = true
   enable_cross_zone_load_balancing = true

   access_logs {
    bucket  = module.s3-bucket-main-nlb-logs.this_s3_bucket_id
    prefix  = "${var.env}-lb"
    enabled = true
  }
  
  tags = {
    Name         = "${var.env}-nlb"
    environment  = var.env
    "Created by" = "terraform"
    "created on" = "${var.created_on}"
  }
}


############ nlb rule for kafka external
resource "aws_lb_target_group" "kafka-external" {
  name     = "${var.env}-kafka-external-1-23"
  port     = var.kafka_nodeport_for_nlb_tg
  protocol = "TCP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "kafka-external" {
  load_balancer_arn = aws_lb.nlb_lambda.arn
  port              = var.kafka_service_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kafka-external.arn
  }
}

resource "aws_autoscaling_attachment" "kafka-external-asg-taget-attachment" {
  autoscaling_group_name = aws_eks_node_group.eks-node-group-kafka-new.resources[0].autoscaling_groups[0].name
  alb_target_group_arn   = aws_lb_target_group.kafka-external.arn
}

############# nlb rule for arangodb external

resource "aws_lb_target_group" "arangodb-external" {
  name     = "${var.env}-arangodb-external"
  port     = var.arangodb_nodeport_for_nlb_tg
  protocol = "TCP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "arangodb-external" {
  load_balancer_arn = aws_lb.nlb_lambda.arn
  port              = var.arangodb_service_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.arangodb-external.arn
  }
}

resource "aws_autoscaling_attachment" "arangodb-external-asg-taget-attachment" {
  autoscaling_group_name = aws_eks_node_group.eks-node-group-arangodb-new.resources[0].autoscaling_groups[0].name
  alb_target_group_arn   = aws_lb_target_group.arangodb-external.arn
}
