Set up Virtual Cloud Network

### [1] Set Default Region and Zone

> gcloud config set compute/region us-central1
> gcloud config set compute/zone us-central1-a

### [2] Create The Network

> gcloud compute networks create kubernetes-network --subnet-mode custom

### [3] Create Subnetwork

> gcloud compute networks subnets create kubernetes-subnetwork \
--network kubernetesnetwork \
--range 10.240.0.0/24

### [4] Creating a firewall rule that allows internal communication across all protocols:

> gcloud compute firewall-rules create kubernetes-internal-allow \
--network kubernetesnetwork \
--allow tcp,udp.icmp \
--source-ranges 10.240.0.0/24,10.200.0.0/16

### [5] Creating a firewall rule that allows external communication across SSH,HTTP,ICMP:

> gcloud compute firewall-rules create kubernetes-external-allow \
--network kubernetesnetwork \
--allow tcp,udp.icmp \
--source-ranges 0.0.0.0/0

### [6] Public IP Address: Allocate a static IP address that will be attached to the external load balancer fronting the Kubernetes API Servers:
> gcloud compute addresses create kubernetes  
--region $(gcloud config get-value compute/region)

### [7] Check-up 
> gcloud compute networks list
> gcloud compute networks subnets list
> gcloud compute firewall-rules list
> gcloud compute addresses list
