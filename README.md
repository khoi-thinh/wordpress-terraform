# Build a 2-tier architecture (Wordpress site) with Terraform
The ogirin article was written by "Kemane Donfack" on the blog: https://blog.numericaideas.com/deploy-wordpress-2-tier-aws-architecture-with-terraform

I made some changes based on the default setup in my company's test environment. Some are already created and can not be deleted so I can only refer to them uing data sources.

Credentials of RDS are stored on AWS Secret Managers following best practice "Avoid storing credentials in text file"
Public subnet are existing (provisioned by Global team) so I only provision 2 new private subnets for RDS.
Only t2.micro and t2.nano are allowed to provision EC2
Tested on Terraform version 1.6.4 (latest at the time of writing this)


