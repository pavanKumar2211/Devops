#########target-group

resource "aws_lb_target_group" "uat-api-gateway-blue" {
  name     = "${var.env}-api-gateway-blue"
  port     = 31144
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-blue-sg3" {
  name     = "${var.env}-api-gateway-blue-sg3"
  port     = 31154
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-blue-sg4" {
  name     = "${var.env}-api-gateway-blue-sg4"
  port     = 31155
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-blue-sg5" {
  name     = "${var.env}-api-gateway-blue-sg5"
  port     = 31156
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-admin-portal-ui-blue" {
  name     = "${var.env}-admin-portal-ui-blue"
  port     = 31145
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-shortlink-svc-blue" {
  name     = "${var.env}-shortlink-svc-blue"
  port     = 31149
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-blue" {
  name     = "${var.env}-red-roses-blue"
  port     = 31151
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-sg3" {
  name     = "${var.environment}-red-roses-sg3"
  port     = 31554
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-sg4" {
  name     = "${var.environment}-red-roses-sg4"
  port     = 31556
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-sg5" {
  name     = "${var.environment}-red-roses-sg5"
  port     = 31558
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-new-blue-red-roses-fork" {
  name     = "${var.env}-blue-red-roses-fork"
  port     = 31552
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}


resource "aws_lb_target_group" "uat-brxm-delivery-blue" {
  name     = "${var.env}-brxm-delivery-blue"
  port     = 31153
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-brxm-ngnix-blue" {
  name     = "${var.env}-brxm-ngnix-blue"
  port     = 31155
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-fork-blue" {
  name     = "${var.env}-blue-red-roses-fork"
  port     = 31552
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-default-target" {
  name     = "${var.env}-default-target"
  port     = 31152
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-moody-nginx" {
  name     = "${var.environment}-moody-nginx"
  port     = 32244
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-moody-nginx-sg3" {
  name     = "${var.environment}-moody-nginx-sg3"
  port     = 32245
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-moody-nginx-sg4" {
  name     = "${var.environment}-moody-nginx-sg4"
  port     = 32246
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-moody-nginx-sg5" {
  name     = "${var.environment}-moody-nginx-sg5"
  port     = 32247
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_listener" "default-alb-listner" {
  load_balancer_arn = module.module_uat.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uat-default-target.arn
  }
}

########################################################
#RULES
########################################################

resource "aws_lb_listener_rule" "manager" {
  listener_arn = aws_lb_listener.default-alb-listner.arn

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "not-found"
      status_code  = "404"
    }
  }

  condition {
    path_pattern {
     values = ["/manager", "/manager/*"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-blue" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-blue.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-r2.fnp.com","api-blue-uat-r2.r2vpc.fnp.com","api-uat-blue.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-blue-sg3" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-blue-sg3.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-sg3-r2.fnp.com","api-blue-uat-sg3.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-blue-sg4" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-blue-sg4.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-sg4-r2.fnp.com","api-blue-uat-sg4.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-blue-sg5" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-blue-sg5.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-sg5-r2.fnp.com","api-blue-uat-sg5.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-admin-portal-ui-blue" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-admin-portal-ui-blue.arn
     }

  condition {
    host_header {
      values = ["admin-portal-blue-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-shortlink-svc-blue" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-shortlink-svc-blue.arn
     }

  condition {
    host_header {
      values = ["zippy-blue-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-red-roses-blue" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-red-roses-blue.arn
     }

  condition {
    host_header {
      values = ["red-roses-blue-uat-r2.fnp.com","m-red-roses-blue-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-red-roses-sg3" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-red-roses-sg3.arn
     }

  condition {
    host_header {
      values = ["red-roses-fork-uat-sg3-r2.fnp.com","m-red-roses-fork-uat-sg3-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-red-roses-sg4" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-red-roses-sg4.arn
     }

  condition {
    host_header {
      values = ["red-roses-fork-uat-sg4-r2.fnp.com","m-red-roses-fork-uat-sg4-r2.fnp.com"]
    }
  }
}
resource "aws_lb_listener_rule" "uat-red-roses-sg5" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-red-roses-sg5.arn
     }

  condition {
    host_header {
      values = ["red-roses-fork-uat-sg5-r2.fnp.com","m-red-roses-fork-uat-sg5-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-new-blue-red-roses-fork" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-new-blue-red-roses-fork.arn
     }

  condition {
    host_header {
      values = ["red-roses-fork-uat-blue-r2.fnp.com","m-red-roses-fork-uat-blue-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-brxm-delivery-blue" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-brxm-delivery-blue.arn
     }

  condition {
    host_header {
      values = ["brxm-site-blue-uat-r2.fnp.com"]
    }
  }
}


resource "aws_lb_listener_rule" "uat-brxm-ngnix-blue" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-brxm-ngnix-blue.arn
     }

  condition {
    host_header {
      values = ["brxm-nginx-blue-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-moody-nginx" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-moody-nginx.arn
     }

  condition {
    host_header {
      values = ["uat-moody-surveys.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-moody-nginx-sg3" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-moody-nginx-sg3.arn
     }

  condition {
    host_header {
      values = ["uat-moody-surveys-sg3.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-moody-nginx-sg4" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-moody-nginx-sg4.arn
     }

  condition {
    host_header {
      values = ["uat-moody-surveys-sg4.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-moody-nginx-sg5" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-moody-nginx-sg5.arn
     }

  condition {
    host_header {
      values = ["uat-moody-surveys-sg5.fnp.com"]
    }
  }
}

###############################################################################
# Attaching all the target groups the autoscaling group ID
###############################################################################
resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-blue" {
  #autoscaling_group_name = module.eks.node_groups.node-group-1.resources[0].autoscaling_groups[0].name

  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-blue.arn

}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-blue-sg3" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-blue-sg3.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-blue-sg4" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-blue-sg4.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-blue-sg5" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-blue-sg5.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-admin-portal-ui-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-admin-portal-ui-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-shortlink-service-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-shortlink-svc-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-red-roses-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-red-roses-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-red-roses-blue-sg3" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-red-roses-sg3.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-red-roses-blue-sg4" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-red-roses-sg4.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-red-roses-blue-sg5" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-red-roses-sg5.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-new-red-roses-fork-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-new-blue-red-roses-fork.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-brxm-delivery-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-brxm-delivery-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-brxm-ngnix-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-brxm-ngnix-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-moody-nginx" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-moody-nginx.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-moody-nginx-sg3" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-moody-nginx-sg3.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-moody-nginx-sg4" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-moody-nginx-sg4.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-moody-nginx-sg5" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-moody-nginx-sg5.arn
}