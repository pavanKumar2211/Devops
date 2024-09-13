#########target-group

resource "aws_lb_target_group" "uat-brxm-blue" {
  name     = "${var.env}-brxm-blue"
  port     = 31157
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-brxm-green" {
  name     = "${var.env}-brxm-green"
  port     = 30157
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-zeus-blue" {
  name     = "${var.env}-api-gateway-zeus-blue"
  port     = 31145
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-zeus-blue-sg3" {
  name     = "${var.env}-api-gw-zeus-blue-sg3"
  port     = 31158
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-zeus-blue-sg4" {
  name     = "${var.env}-api-gw-zeus-blue-sg4"
  port     = 31159
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-zeus-blue-sg5" {
  name     = "${var.env}-api-gw-zeus-blue-sg5"
  port     = 31160
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-api-gateway-zeus-green" {
  name     = "${var.env}-api-gateway-zeus-green"
  port     = 31245
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-zeus-frontend-blue" {
  name     = "${var.env}-zeus-frontend-blue"
  port     = 31150
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-zeus-frontend-blue-sg3" {
  name     = "${var.env}-zeus-frontend-blue-sg3"
  port     = 31161
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-zeus-frontend-blue-sg4" {
  name     = "${var.env}-zeus-frontend-blue-sg4"
  port     = 31162
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-zeus-frontend-blue-sg5" {
  name     = "${var.env}-zeus-frontend-blue-sg5"
  port     = 31163
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-zeus-frontend-green" {
  name     = "${var.env}-zeus-frontend-green"
  port     = 30150
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-istio-ingress-gateway" {
  name     = "${var.environment}-istio-ingress-gateway"
  port     = 31809
  protocol = "HTTPS"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "uat-solr" {
  name     = "${var.env}-solr"
  port     = 31234
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

resource "aws_lb_target_group" "kiali-uat-new" {
  name     = "kiali-${var.env}"
  port     = 31690
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

########################################################
#########target-group for secure_alb_tg
########################################################
resource "aws_lb_target_group" "uat-secure-tg" {
  name     = "${var.env}-secure-tg"
  port     = 31150
  protocol = "HTTP"
  vpc_id   = module.module_uat.vpc_id
}

########################################################
######### Default aws_lb_listener for secure_alb_tg
########################################################
resource "aws_lb_listener" "uat-secure_alb_listener" {
  load_balancer_arn = module.module_uat.secure_alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uat-secure-tg.arn
  }
}

########################################################
######### Custom aws_lb_listener for secure_alb_tg
########################################################

resource "aws_lb_listener_rule" "kiali-uat-new" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.kiali-uat-new.arn
     }

  condition {
    host_header {
      values = ["kiali-uat.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-brxm-blue" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-brxm-blue.arn
     }

  condition {
    host_header {
      values = ["brxm-cms-blue-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-brxm-green" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-brxm-green.arn
     }

  condition {
    host_header {
      values = ["brxm-cms-green-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-zeus-blue" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-zeus-blue.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-zeus-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-zeus-blue-sg5" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-zeus-blue-sg5.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-zeus-sg5-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-zeus-blue-sg3" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-zeus-blue-sg3.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-zeus-sg3-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-zeus-blue-sg4" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-zeus-blue-sg4.arn
     }

  condition {
    host_header {
      values = ["api-blue-uat-zeus-sg4-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-api-gateway-zeus-green" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-api-gateway-zeus-green.arn
     }

  condition {
    host_header {
      values = ["api-green-uat-zeus-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-zeus-frontend-blue" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-zeus-frontend-blue.arn
     }

  condition {
    host_header {
      values = ["zeus-blue-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-zeus-frontend-blue-sg3" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-zeus-frontend-blue-sg3.arn
     }

  condition {
    host_header {
      values = ["zeus-blue-uat-sg3-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-zeus-frontend-blue-sg4" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-zeus-frontend-blue-sg4.arn
     }

  condition {
    host_header {
      values = ["zeus-blue-uat-sg4-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-zeus-frontend-blue-sg5" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-zeus-frontend-blue-sg5.arn
     }

  condition {
    host_header {
      values = ["zeus-blue-uat-sg5-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-zeus-frontend-green" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-zeus-frontend-green.arn
     }

  condition {
    host_header {
      values = ["zeus-green-uat-r2.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-solr" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-solr.arn
     }

  condition {
    host_header {
      values = ["solr-uat-r2.fnp.com","solr-uat.r2vpc.fnp.com"]
    }
  }
}

resource "aws_lb_listener_rule" "uat-istio-ingress-gateway" {
  listener_arn = aws_lb_listener.uat-secure_alb_listener.arn
  #priority     = 99

  action {
    type = "forward"
    target_group_arn     = aws_lb_target_group.uat-istio-ingress-gateway.arn
     }

  condition {
    host_header {
      values = ["uat-ingress-solr.r2vpc.fnp.com","arangodb-uat.r2vpc.fnp.com","uat-kafka-ui.r2vpc.fnp.com","kibana-uat.r2vpc.fnp.com","mongoclient-uat.r2vpc.fnp.com"]
    }
  }
}

###############################################################################
# Attaching all the target groups the autoscaling group ID
###############################################################################

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-brxm-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-brxm-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-brxm-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-brxm-green.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-zeus-blue" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-zeus-blue.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-zeus-blue-sg3" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-zeus-blue-sg3.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-zeus-blue-sg4" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-zeus-blue-sg4.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-zeus-blue-sg5" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-zeus-blue-sg5.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-api-gateway-zeus-green" {
  autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
  alb_target_group_arn   = aws_lb_target_group.uat-api-gateway-zeus-green.arn

}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-zeus-frontend-blue" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-zeus-frontend-blue.arn
} 

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-zeus-frontend-blue-sg3" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-zeus-frontend-blue-sg3.arn
} 

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-zeus-frontend-blue-sg4" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-zeus-frontend-blue-sg4.arn
} 

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-zeus-frontend-blue-sg5" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_blue_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-zeus-frontend-blue-sg5.arn
} 

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-zeus-frontend-green" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_green_autoscaling_groups_name
   alb_target_group_arn   = aws_lb_target_group.uat-zeus-frontend-green.arn
} 

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-solr" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_autoscaling_groups_name_solr
   alb_target_group_arn   = aws_lb_target_group.uat-solr.arn
} 

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-istio-ingress-gateway" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_autoscaling_groups_name_solr
   alb_target_group_arn   = aws_lb_target_group.uat-istio-ingress-gateway.arn
}

resource "aws_autoscaling_attachment" "uat-eks-asg-taget-attachment-kiali" {
   autoscaling_group_name = module.module_uat.eks_node_group_app_autoscaling_groups_name_kafka
   alb_target_group_arn   = aws_lb_target_group.kiali-uat-new.arn
}