# Mesosphere DCOS, Azure, Docker, VMware & Everything Between
These days, I try to be involved in any Containers, DevOps, Automation, etc. related discussion. Part of my role is to consult my customers around how to architect their containers platform and orchestration tools in Azure. But what happens when you have a chance to do something cool like architecting a solution which involves Mesosphere DC/OS, Azure Container Service, Azure Container Registry, Docker and VMware vSphere?! Let’s find out…

In this first multiple-part blog post series I will describe the motivation behind it, the requirements & constraints, architecture and of course the “how to” – let’s begin.

#### Motivation, Requirements & Constraints

The motivation for this one was pretty straightforward – start looking into Docker containers and integrate several applications with it.

Without going into too many details, I had one major constraint – The DevOps team had the production environment deployed on top of vSphere and it’s dev/QA/integration environments in Azure. Why this is constraint you might ask?! well, you will soon find out.

As for requirements, those were the main ones:

Use Azure Container Service with DC/OS
Store Docker images in the same private container registry which will be used by all parties – dev/QA/integration/Prod
Unified containers orchestration platform across all stacks
Going back to the constraint part for a second, the reason I consider this a constraint is because if the production was also part of Azure, I wouldn’t have to do anything with regard to vSphere and everything was pure “cloudish”.

#### Dev to Production CI/CD Flow

The continuous integration and deployment flow presented below goes as follow:

A developer does some coding on a container deployed locally on his workstation.
He then pushes an “Integration Ready” docker image to a private container registry.
Integration team pulls the image into a DC/OS cluster deploy on Azure to do some extra integration and testing work. Once done, a new “Production Ready” image is being pushed to the container registry.
The “Production Ready” container is being pulled to the DC/OS production cluster deployed on vSphere.

![alt text](https://i1.wp.com/imallvirtual.com/wp-content/uploads/2017/05/Flow.jpg)

#### Architecture

Below is the infrastructure logical design for our deployment which will serve the process previously described. Please note that I will not touch the Visual Studio Team Services (VSTS) or the Team Foundation Server (TFS) in this series as I wanted to focus more on the infra side of things.  

![alt text](https://i2.wp.com/imallvirtual.com/wp-content/uploads/2017/05/Hybrid-DCOS-Platform-1.jpg?w=1280)

In the next part, I will be talking about the DC/OS 1.9 deployment on top of vSphere. I went with the advanced way of doing things so I will share my knowledge around the configurations, caveats and steps needed for such a deployment.  