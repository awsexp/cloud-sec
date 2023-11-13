#!/bin/bash

# Always Encrypt new EBS Volumes Across all Regions
# Developed by Ben Fellows https://x.com/awsexp
# Reference: https://go.aws/49u8UOf
# AWS Console: https://go.aws/3uaZ7fT

export AWS_PAGER=""

#prompt for confirmation before running or exit
read -p "This will set EBS Encryption to default in all regions. Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "Disabling EBS block public access in $region..."
    
    # Always encrypt new EBS volumes
    aws ec2 enable-ebs-encryption-by-default \
        --region $region
done

echo "Done."
