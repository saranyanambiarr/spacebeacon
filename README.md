We all know that deployment can be a hassle for any type of application. We believe with Terraform it can be hassle free to deploy on whichever cloud platform you need so that your application can be accessed publicly with security. Let’s have a short overview of these applications before our space engineer embarks on the mission.

AWS EKS - Amazon EKS is a managed Kubernetes service to run Kubernetes in the AWS Cloud. 
Terraform - Terraform is an Infrastructure as Code (IaC) tool that allows you to build, change and version infrastructure safely and efficiently.

Let’s have a look at the overall steps for deploying a web app from GitHub on AWS EKS using Terraform & Helm -

1. Creating a Docker image of the application.
2. Writing a Terraform code to create an infrastructure to deploy our application.
3. Deploy your Helm chart to the EKS cluster using the kubeconfig you received from Terraform.

✅Step 1: 

The first step would be creating a Docker image and pushing it to the Container Registry. To complete this step, we need to

- Create a Workspace.
- Make a simple application that listens on port 80 and responds to HTTP GET requests with a simple sentence. Here, I have used Python to create the application.
- Create the DockerFile.
- Build the image from the DockerFile.
- Test the image locally.
- Push the final image to the container registry of your choice.

This can be done locally if you have Docker installed or you can use any online Docker playground available.

Make sure that your code and requirement.txt file are up to date before creating and building your Dockerfile. It’s a prerequisite as without that you will run into a lot of errors and you’ll have to keep editing and building the Dockerfile.
Use the docker cmds - 1. docker build 2. docker images 3. docker run to get the application working.

✅Step 2

A Terraform file is required to be created to build the infrastructure for our application to be deployed.

Files created are -

1. provider-vpc.tf - Specifying provider details and vpc instructions
2. security-group.tf - Defining the security groups which will be used by worker nodes.
3. ekscluster.tf - Defining inputs to create cluster.
4. output.tf - Returning the some important fields to get the information about our EKS infrastructure
5. versions.tf - Defining version constraints along with a provider as AWS.

Once all your terraform files are ready, proceed to Step 3.

✅Step 3:

Run the cmds in order 1. terraform init 2. terraform validate 3. terraform plan 4. terraform apply

Create the Helm chart by running the cmd: helm create chart-name
A terraform file for helm release has the providers, the chart name and the load balancer hostname that I want as output for viewing my application.

Run the same Terraform commands in this workspace too and get the LoadBalancer hostname as output.
