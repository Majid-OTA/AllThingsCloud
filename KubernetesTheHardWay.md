### [1] Set Default Region and Zone
gcloud config set compute\region us-central1-a
### [2] Create The Network
gcloud compute networks create kubernetesnetwork --subnet-mode custom
### [3] Create Subnetwork
> gcloud compute networks subnets create kubernetessubnetwork \
--network kubernetesnetwork
--range 10.240.0.0/24


