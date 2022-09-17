# 3-cicd
A pipeline using Github Actions to
* Login to Docker Hub
* Build the bitcoin-core Docker image
* Upload the image to Docker Hub
* Generate a Software Bill of Materials using Syft
* Scan the SBOM using Grype
* Test the k8s manifest for deploying the image with Datree
* Deploy the manifest using kubectl
