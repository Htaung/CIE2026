# VPC Peering - Terraform Cloud - Remote Exec

Date: October 19, 2026 6:58 PM
Hands on: Not started

[https://app.notion.com/p/CNFP1-Session-35-Terraform-Session-04-05-Sep-2024-3c548d70c8c3804f8519d60523cabb8d](https://app.notion.com/p/CNFP1-Session-35-Terraform-Session-04-05-Sep-2024-3c548d70c8c3804f8519d60523cabb8d?pvs=21)

#### Create 6 workspaces and create aws dynamic credential under Variables in terraform cloud

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image.png)

- Create workspace

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%201.png)

- Create AWS dynamic credential

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%202.png)

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%203.png)

#### Goto each workspace’s setting remote state sharing, tick Share with all workspaces in this project

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%204.png)

#### Running fe-network from local computer that was executing under HCP Cloud

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%205.png)

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%206.png)

- fe-network-ws overview after terraform apply

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%207.png)

- fe-network-ws state file have been generated

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%208.png)

#### Running fe-security from local computer that was executing under HCP Cloud

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%209.png)

```jsx
Add data.tf under fe-security 

data "aws_vpc" "hc_frontend_vpc" {
  tags = { Name = "${var.frontend_prefix}-vpc" } 
}

edit frontend-security-group.tf
change 
vpc_id      = data.aws_vpc.hc_frontend_vpc.id
```

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2010.png)

- fe-security-ws overview after terraform apply

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2011.png)

- How to use remote sharing state properly

```jsx
1. fe-network folder: expose the value in output.tf, then apply it.

output "frontend_vpc_id" {
  value = aws_vpc.hc_frontend_vpc.id
}

Only outputs are shared, not resources. Without an output, nothing is available to read.

2. fe-security folder: read it with data.tf.
data "tfe_outputs" "fe_network" {
  organization = "aungcloud-tfc"
  workspace    = "fe-network-ws"
}

Add the provider to version.tf and then run terraform init again.
terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
    tfe = { source = "hashicorp/tfe" }
  }
}

3. Use it in frontend-security-group.tf. Replace the reference in each security group:
vpc_id = data.tfe_outputs.fe_network.values.frontend_vpc_id

aung@Aung-Ubuntu:~/CIE2026/TerraformCloudVPCPeeringCLI/fe-network$ terraform apply
Running apply in HCP Terraform. Output will stream here. Pressing Ctrl-C
will cancel the remote apply if it's still pending. If the apply started it
will stop streaming the logs, but will not stop the apply running remotely.

aung@Aung-Ubuntu:~/CIE2026/TerraformCloudVPCPeeringCLI/fe-security$ terraform apply -auto-approve
Running apply in HCP Terraform. Output will stream here. Pressing Ctrl-C
will cancel the remote apply if it's still pending. If the apply started it
will stop streaming the logs, but will not stop the apply running remotely.

```

- fe-compute-ws overview after terraform apply

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2012.png)

- be-network-ws overview after terraform apply

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2013.png)

```jsx

│ Warning: Authentication method has limited TFE provider permissions
│ 
│   with provider["registry.terraform.io/hashicorp/tfe"],
│   on <empty> line 0:
│   (source code not available)
│ 
│ When running in HCP Terraform or Terraform Enterprise, the current
│ authentication method may not have sufficient permissions for all TFE
│ provider operations. Data sources and plans may work, but resource create,
│ update, or delete operations can fail. To avoid this, authenticate using
│ the provider token argument or the TFE_TOKEN environment variable.
╵
╷
│ Warning: Authentication method has limited TFE provider permissions
│ 
│   with provider["registry.terraform.io/hashicorp/tfe"],
│   on <empty> line 0:
│   (source code not available)
│ 
│ When running in HCP Terraform or Terraform Enterprise, the current
│ authentication method may not have sufficient permissions for all TFE
│ provider operations. Data sources and plans may work, but resource create,
│ update, or delete operations can fail. To avoid this, authenticate using
│ the provider token argument or the TFE_TOKEN environment variable.

```

- be-security-ws overview after terraform apply

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2014.png)

- be-compute-ws overview after terraform apply
- 

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2015.png)

```jsx
The key isn’t in your local folder, because the local_file resource wrote it on the temporary HCP Terraform runner, which is deleted after the run. The real key is saved in fe-compute-ws’s state, and your output.tf already exposes it.

```

- get key pairs for be

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2016.png)

- get key pairs for fe

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2017.png)

- ssh into **hc-frontend-public-instance01** and ping to **hc-frontend-private-instance01**

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2018.png)

ssh from **hc-frontend-private-instance01 to hc-frontend-private-instance02 and hc-frontend-private-instance03**

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2019.png)

ssh from **hc-frontend-private-instance01 to hc-frontend-private-instance02 and**

ping to **hc-backend-private-instance02** 

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2020.png)

ssh from **hc-frontend-private-instance01 to hc-frontend-private-instance02 and**

ping to **hc-backend-private-instance02** 

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2021.png)

ssh/ping from **hc-backend-public-instance01 to hc-backend-private-instance01**

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2022.png)

ssh/ping from **hc-backend-private-instance01 to hc-backend-private-instance02 and 3**

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2023.png)

ping from **hc-backend-private-instance02 to hc-frontend-private-instance02**

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2024.png)

ping from **hc-backend-private-instance03 to hc-frontend-private-instance03**

![image.png](VPC%20Peering%20-%20Terraform%20Cloud%20-%20Remote%20Exec/image%2025.png)

```jsx
for d in fe-compute be-compute fe-security be-security be-network fe-network; do
  (cd "$d" && terraform destroy -auto-approve) || break
done
```