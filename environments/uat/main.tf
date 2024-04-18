# module "mig-test" {
#   source          = "../modules"
#   svc_project_id  = var.svc_project_id
#   host_project_id = var.host_project_id
#   gke_cluster     = var.gke_cluster
#   #gke_release_channel = var.gke_release_channel
# }

  module "MIG-https-lb" {
  source = "../../modules" 
  project           = var.project
  project_id = var.project
  # network_name    = var.network_name
  # firewall_networks = var.firewall_networks
  target_size = 1
  update_policy = var.update_policy
  subnetwork = var.subnetwork
  distribution_policy_zones = var.distribution_policy_zones 
  # url_map_name      = google_compute_url_map.example.name  # Provide the name of the existing URL map
  # Add any other required variables for the gce-lb-http module

  named_ports               = var.named_ports
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