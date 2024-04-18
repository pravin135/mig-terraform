# # module "gce-lb-http" {
# #   source  = "terraform-google-modules/lb-http/google"
# #   version = "~> 10.0"
# #   name    = var.network_prefix
# #   project = var.project
# #   firewall_networks = var.firewall_networks
# #   backends = {
# #     default = {

# #       protocol    = "HTTP"
# #       port        = 8080
# #       port_name   = "http"
# #       timeout_sec = 10
# #       enable_cdn  = false
# #       balancing_mode  = "RATE"
# #       max_rate_per_instance = 20
# #       health_check = {
# #         request_path = "/"
# #         port         = 8080
# #         protocol = "TCP"
# #       }

# #       log_config = {
# #         enable      = true
# #         sample_rate = 1.0
# #       }

# #       groups = [
# #         {
# #           group = module.mig.instance_group
# #         },
# #       ]

# #       iap_config = {
# #         enable = false
# #       }
# #     }
# #   jenkins-backend = {
# #       protocol    = "HTTP"
# #       port        = 8080
# #       port_name   = "http"
# #       timeout_sec = 10
# #       enable_cdn  = false
# #            balancing_mode               = "RATE" 
# #            capacity_scaler              = 1 
# #            max_connections              = 0 
# #            max_connections_per_endpoint = 0 
# #            max_rate                     = 0 
# #            max_rate_per_endpoint        = 0 
# #            max_rate_per_instance        = 20 
# #             max_utilization              = 0 
# #       health_check = {
# #         request_path = "/"
# #         port         = 8080
# #         protocol = "TCP"
# #       }
# #             log_config = {
# #         enable      = true
# #         sample_rate = 1.0
# #       }

# #       groups = [
# #         {
# #           group = module.mig.instance_group
# #         },
# #       ]

# #       iap_config = {
# #         enable = false
# #       }
# #     }
# #   }
# # }

# # resource "google_compute_global_address" "default" {
# #   project      = var.project_id # Replace this with your service project ID in quotes
# #   name         = "ipv4-address"
# #   address_type = "EXTERNAL"
# #   ip_version   = "IPV4"
# # }

# resource "google_compute_address" "gcp-lb-ip" {
#   name         = "mig-lb-ip"
#   address_type = "EXTERNAL"
#   network_tier = "PREMIUM"
#   region       = "asia-south1"
# }

# # resource "google_compute_forwarding_rule" "default" {
# #   provider = google-beta
# #   # depends_on = [google_compute_subnetwork.proxy]
# #   name   = "jenkins-forwarding-rule"
# #   region = "asia-south1"

# #   ip_protocol           = "TCP"
# #   load_balancing_scheme = "EXTERNAL_MANAGED"
# #   port_range            = "8080"
# #   target                = google_compute_region_target_https_proxy.default.id
# #   network               = "projects/gke-pocs/global/networks/poc-vpc-gke"
# #   ip_address            = google_compute_address.gcp-lb-ip.id
# #   network_tier          = "PREMIUM"
# # }

# # resource "google_compute_region_target_https_proxy" "default" {
# #   name             = "l7-mig-proxy"
# #   url_map          = google_compute_url_map.mig-url.id
# #   ssl_certificates = [google_compute_ssl_certificate.default.id]
# # }

# resource "google_compute_ssl_certificate" "default" {
#   name_prefix = "devopsfreak-certs"
#   description = "my-certificates"
#   private_key = file("/home/mohammed02asif/mig-terraform/modules/private.key")
#   certificate = file("/home/mohammed02asif/mig-terraform/modules/ssl-cert.crt")

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "google_compute_url_map" "mig-url" {
#   // note that this is the name of the load balancer
#   name            = var.network_name
#   default_service = module.gce-lb-https.backend_services["default"].self_link

#   host_rule {
#     hosts        = ["devopsfreak.shop"]
#     path_matcher = "allpaths"
#   }

#   path_matcher {
#     name            = "allpaths"
#     default_service = module.gce-lb-https.backend_services["default"].self_link

#     path_rule {
#       paths = ["/*"]
#       service = module.gce-lb-https.backend_services["default"].self_link
#     }

# #     # path_rule {
# #     #   paths = [
# #     #     "/group2",
# #     #     "/group2/*"
# #     #   ]
# #     #   service = module.gce-lb-https.backend_services["mig2"].self_link
# #     # }

# #     # path_rule {
# #     #   paths = [
# #     #     "/group3",
# #     #     "/group3/*"
# #     #   ]
# #     #   service = module.gce-lb-https.backend_services["mig3"].self_link
# #     # }

# #     # path_rule {
# #     #   paths = [
# #     #     "/assets",
# #     #     "/assets/*"
# #     #   ]
# #     #   service = google_compute_backend_bucket.assets.self_link
# #     # }
# #   }
#  }
# }
# module "gce-lb-https" {
#   source  = "terraform-google-modules/lb-http/google"
#   version = "~> 10.0"
#   name    = var.network_name
#   project = var.project
#   address = google_compute_address.gcp-lb-ip.address
#   firewall_networks = var.firewall_networks
#   create_url_map    = false
#   url_map = google_compute_url_map.mig-url.self_link
#   ssl_certificates = [google_compute_ssl_certificate.default.id]
  
#   ssl               = true
#   backends = {
#     default = {
#       protocol    = "HTTP"
#       port        = 8080
#       port_name   = "http"
#       timeout_sec = 10
#       enable_cdn  = false
#       health_check = {
#         request_path = "/"
#         port         = 8080
#         protocol = "TCP"
#       }
#       log_config = {
#         enable      = true
#         sample_rate = 1.0
#       }
#       groups = [
#         {
#           # Each node pool instance group should be added to the backend.
#           group                        = module.mig.instance_group
#           balancing_mode               = "RATE"
#           capacity_scaler              = null
#           description                  = null
#           max_connections              = null
#           max_connections_per_instance = null
#           max_connections_per_endpoint = null
#           max_rate                     = null
#           max_rate_per_instance        = 20
#           max_rate_per_endpoint        = null
#           max_utilization              = null
#         },
#       ]
#       iap_config = {
#         enable = false
#       }
#     }
#     # jenkins-backend = {
#     #   protocol    = "HTTP"
#     #   port        = 8080
#     #   port_name   = "http"
#     #   timeout_sec = 10
#     #   enable_cdn  = false
#     #   balancing_mode               = "RATE"
#     #   capacity_scaler              = 1 
#     #   max_connections              = 0 
#     #   max_connections_per_endpoint = 0 
#     #   max_rate                     = 0 
#     #   max_rate_per_endpoint        = 0 
#     #   max_rate_per_instance        = 20 
#     #   max_utilization              = 0 
#     #   health_check = {
#     #     request_path = "/"
#     #     port         = 8080
#     #     protocol = "TCP"
#     #   }
#     #   log_config = {
#     #     enable      = true
#     #     sample_rate = 1.0
#     #   }
#     #   groups = [
#     #     {
#     #       group = module.mig.instance_group
#     #     },
#     #   ]
#     #   iap_config = {
#     #     enable = false
#     #   }
#     # }
#   }
# }
