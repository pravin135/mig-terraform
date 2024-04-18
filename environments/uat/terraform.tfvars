project_id = "gke-pocs"
region = "asia-south1"
subnetwork = "projects/gke-pocs/regions/asia-south1/subnetworks/poc-subnet"
target_size = "1"
distribution_policy_zones = ["asia-south1-a"]
# firewall_networks = ["projects/gke-pocs/global/networks/poc-vpc-gke"]
 project = "gke-pocs"
 network_name = "test-mig-lb"
named_ports = [
  {
    name = "http"
    port = 8080
  },
]
# Define the maximum number of instances that the autoscaler can scale up to.
max_replicas = 3

# Define the minimum number of replicas that the autoscaler can scale down to.
min_replicas = 1

# Define the cooldown period in seconds that the autoscaler should wait before collecting information from a new instance.
cooldown_period = 300

# Define the autoscaling CPU utilization policy block as a single element array.
autoscaling_cpu = [
  {
    target = "0.7"  # The target CPU utilization as a percentage (0.6 = 60%)
    predictive_method = "NONE"
  }
]

# Define the autoscaling metric policy block as a single element array.
autoscaling_metric = []


# Define the autoscaling load balancing utilization policy block as a single element array.
autoscaling_lb = []

# Define the autoscaling scale-in control block.

# Specify whether autoscaling should be enabled or disabled.
autoscaling_enabled = true
distribution_policy_target_shape = "EVEN"
update_policy = [{
  type                           = "PROACTIVE"
  instance_redistribution_type   = "PROACTIVE"
  minimal_action                 = "REPLACE"
  most_disruptive_allowed_action = "REPLACE"
  max_surge_fixed                = 0
  max_surge_percent              = null  # Must be null if maxSurge_fixed is used
  max_unavailable_fixed          = 1
  max_unavailable_percent        = null  # Use fixed value
  min_ready_sec                  = 60
  replacement_method             = "RECREATE"  # Ensure maxSurge is 0
}]


