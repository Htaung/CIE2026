- Credentials come from AWS_PROFILE or the AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY env vars.
- rout53 zone id was already created


#### cidrsubnet(var.vpc_cidr, 8, count.index) what does this do?
- cidrsubnet(prefix, newbits, netnum)
```
Argument	Meaning
prefix  	the big network to split, here the VPC’s 10.0.0.0/16
newbits	    how many bits to add to the prefix length. /16 + 8 = /24
netnum	    which of the resulting subnets you want (counting from 0)
```

- cidrsubnet("10.0.0.0/16", 8, 0)   → 10.0.0.0/24    public az1  (count.index = 0)
- cidrsubnet("10.0.0.0/16", 8, 1)   → 10.0.1.0/24    public az2  (count.index = 1)
- cidrsubnet("10.0.0.0/16", 8, 10)  → 10.0.10.0/24   private az1 (count.index 0 + 10)
- cidrsubnet("10.0.0.0/16", 8, 11)  → 10.0.11.0/24   private az2 (count.index 1 + 10)


```
terraform console
> cidrsubnet("10.0.0.0/16", 8, 10)
"10.0.10.0/24"
> cidrsubnet("10.0.0.0/16", 4, 10)
"10.0.160.0/20"
> cidrsubnet("10.0.0.0/16", 4, 0)
"10.0.0.0/20"
> cidrsubnet("10.0.0.0/16", 4, 1)
"10.0.16.0/20"
> cidrsubnet("10.0.0.0/16", 4, 2)
"10.0.32.0/20"
```

#### how var.name map to modules/region
1. The root sets the value
```
module "us" {
  source = "./modules/region"
  name   = "us"        # <- the value is set here
  ...
}
```
2. The module declares the parameter
```
In modules/region/variables.tf


variable "name" { type = string }
```
3. Every file in the module can read it
```
tags = { Name = "jump-${var.name}" }
```

#### Why compute.tf can see it without any import
```
Terraform doesn’t treat each .tf file separately. 
It merges all .tf files in a folder into one module. 
variables.tf, vpc.tf, compute.tf and the rest are just a way of organizing the same module, so a variable declared in one is visible in all of them. 
The same goes for resources: compute.tf uses aws_subnet.public[0], which is defined in vpc.tf, with no import. 
```
#### Same code, three different results
- module "sg" {}
- module "us" {}
- module "eu" {}


| Module / Call | var.name | Jumphost Tag | Key Pair Name |
| :--- | :--- | :--- | :--- |
| **sg** | `jump-sg` | `key-sg` | *(Not provided)* |
| **us** | `jump-us` | `key-us` | *(Not provided)* |
| **eu** | `jump-eu` | `key-eu` | *(Not provided)* |




####  geolocation_routing_policy {continent = var.continent        # "AS", "NA" or "EU"}

# Route 53 Geolocation Records

All four records share the same name and type (`htaunghtaung.space`, `A`). Route 53 allows this because each record has a unique `set_identifier`; the geolocation policy decides which one answers.

| Record  | Created by      | `set_identifier` | Matches                  |
|---------|-----------------|------------------|--------------------------|
| sg      | `module "sg"`   | `sg`             | continent `AS`           |
| us      | `module "us"`   | `us`             | continent `NA`           |
| eu      | `module "eu"`   | `eu`             | continent `EU`           |
| default | root `main.tf`  | `default`        | country `*` (everyone else) |

## Notes

- The `sg`, `us` and `eu` records are created inside `modules/region/alb.tf`, one per module call.
- The `default` record is defined once in the root `main.tf` and points at the sg ALB.
- `continent` accepts: `AF`, `AN`, `AS`, `EU`, `NA`, `OC`, `SA`.
- `country` accepts a two-letter ISO code (e.g. `SG`, `US`, `DE`), or `*` for the default record.
- Most specific match wins: country > continent > default.
- Users from `AF`, `OC` and `SA` currently fall through to `default` (sg).

## Expected resources in `terraform plan`

```
module.sg.aws_route53_record.geo
module.us.aws_route53_record.geo
module.eu.aws_route53_record.geo
aws_route53_record.default
```



```
Run with terraform apply -var 'allowed_ssh_cidr=203.0.113.5/32' (or put it in a terraform.tfvars file, which you keep out of git). The two-step apply for the hosted zone and nameservers is the same as before.

allowed_ssh_cidr is your public ip

terraform plan -var 'allowed_ssh_cidr=203.0.113.5/32'
terraform apply -var 'allowed_ssh_cidr=116.86.53.71/32'

terraform destroy -var 'allowed_ssh_cidr=116.86.53.71/32'

terraform.tfvars
allowed_ssh_cidr=116.86.53.71/32


be careful about certticate creation on aws ACM, said free, not sure



curl -4 https://checkip.amazonaws.com
```