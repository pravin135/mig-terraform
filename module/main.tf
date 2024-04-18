
# module "instance_template" {
#   source  = "terraform-google-modules/vm/google//modules/instance_template"
#   version = "~> 11.0"

#   project_id         = var.project_id
#   subnetwork         = var.subnetwork
#   service_account    = var.service_account
#   subnetwork_project = var.project_id
# }

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 11.0"

  project_id        = var.project_id
  region           = var.region
  distribution_policy_zones = var.distribution_policy_zones
  target_size       = var.target_size
  hostname          = "mig-simple"
  instance_template = "projects/gke-pocs/regions/asia-south1/instanceTemplates/instance-template-etl-vm"
   update_policy             = var.update_policy
  distribution_policy_target_shape = var.distribution_policy_target_shape
  named_ports               = var.named_ports
    /* health check */
  health_check = var.health_check
    /* autoscaler */
  autoscaling_enabled          = var.autoscaling_enabled
  max_replicas                 = var.max_replicas
  min_replicas                 = var.min_replicas
  cooldown_period              = var.cooldown_period
  autoscaling_cpu              = var.autoscaling_cpu
  autoscaling_metric           = var.autoscaling_metric
  autoscaling_lb               = var.autoscaling_lb
  autoscaling_scale_in_control = var.autoscaling_scale_in_control
}