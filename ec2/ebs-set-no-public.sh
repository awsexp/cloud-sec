#!/bin/bash

# Block Public Sharing of ONLY NEW Amazon EBS Snapshots Across all Regions
# Developed by Ben Fellows https://x.com/awsexp
# Reference: https://go.aws/3FVHuDq
# Blog: https://go.aws/3SuTKCl
# AWS Console: https://go.aws/3uaZ7fT

export AWS_PAGER=""

#prompt for confirmation before running or exit
read -p "This will set NEW EBS Snapshots to block public sharing in all regions. Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "EBS block public access in $region... with new sharing flag"
    
    # Disable EBS block public access
        
    aws ec2 enable-snapshot-block-public-access \
        --region $region \
        --state block-new-sharing
done

echo "Done."
