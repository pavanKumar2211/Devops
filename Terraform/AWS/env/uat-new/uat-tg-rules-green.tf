#########target-group

resource "aws_lb_target_group" "uat-api-gateway-green" {
  name     = "${var.env}-api-gateway-green"
  port     = 30144
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-admin-portal-ui-green" {
  name     = "${var.env}-admin-portal-ui-green"
  port     = 30145
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-shortlink-svc-green" {
  name     = "${var.env}-shortlink-svc-green"
  port     = 30149
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-green" {
  name     = "${var.env}-red-roses-green"
  port     = 30151
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-brxm-delivery-green" {
  name     = "${var.env}-brxm-delivery-green"
  port     = 30153
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-brxm-ngnix-green" {
  name     = "${var.env}-brxm-ngnix-green"
  port     = 30155
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-red-roses-fork-green" {
  name     = "${var.env}-red-roses-fork-green"
  port     = 31552
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}
/*
resource "aws_lb_target_group" "uat-default-target" {
  name     = "${var.env}-red-roses"
  port     = 31152
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
*/

########################################################
#RULES
########################################################
/*
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
}*/

resource "aws_lb_listener_rule" "uat-red-roses-fork-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-red-roses-fork-green.arn
     }

  condition {
    host_header {
      values = ["red-roses-fork-green-uat-r2.fnp.com","m-red-roses-fork-green-uat-r2.fnp.com"]
    } 
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-green.arn
     }

  condition {
    host_header {
      values = ["api-green-uat-r2.fnp.com","api-green-uat-r2.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-admin-portal-ui-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-admin-portal-ui-green.arn
     }

  condition {
    host_header {
      values = ["admin-portal-green-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-shortlink-svc-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-shortlink-svc-green.arn
     }

  condition {
    host_header {
      values = ["zippy-green-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-red-roses-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-red-roses-green.arn
     }

  condition {
    host_header {
      values = ["red-roses-green-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-brxm-delivery-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-brxm-delivery-green.arn
     }

  condition {
    host_header {
      values = ["brxm-site-green-uat-r2.fnp.com"]
    }
  }
}


resource "aws_lb_listener_rule" "uat-brxm-ngnix-green" {
  listener_arn = aws_lb_listener.default-alb-listner.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-brxm-ngnix-green.arn
     }

  condition {
    host_header {
      values = ["brxm-nginx-green-uat-r2.fnp.com"]
    }
  }
}

###############################################################################
# Attaching all the target groups the autoscaling group ID
###############################################################################
resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-green" {
  #autoscaling_group_name = module.eks.node_groups.node-group-1.resources[0].autoscaling_groups[0].name

  autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-green.arn

}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-admin-portal-ui-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-admin-portal-ui-green.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-shortlink-service-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-shortlink-svc-green.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-red-roses-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-red-roses-green.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-brxm-delivery-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-brxm-delivery-green.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-brxm-ngnix-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-brxm-ngnix-green.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-red-roses-fork-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-red-roses-fork-green.arn
}