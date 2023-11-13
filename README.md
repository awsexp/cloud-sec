# cloud-sec-tools

Just a collection of really simple scripts for helping with cloud security.

I'll be releasing more from some other repos over next few weeks including existing python and node js tooling I've created over the years.

Disclaimer: These are only ad-hoc for use for specific issues and for a proper AWS Security audit and advice please contact me:

- email: ben@teemops.com
- X: https://x.com/awsexp

## Pre-requsites

awscli: https://go.aws/47vq8ZG

## Categories

### EC2 / EBS

Notes for EBS Snapshots Public Sharing:
With EBS Snapshots Public Sharing you can either select all or new. The difference is that if you select all, previous publicly shared EBS Snapshots will be automatically set to private.

You can still share individual EBS snapshots between other AWS accounts.

- [Disable AMI Public Sharing in All Regions](ec2/ami-set-no-public.sh)
- [Disable New EBS Public Sharing in All Regions](ec2/ebs-set-no-public.sh)
- [Disable ALL EBS Public Sharing in all Regions](ec2/ebs-set-no-public-all.sh)
- [Enable EBS Encryption Always in all Regions ](ec2/ebs-set-always-encrypt.sh)
