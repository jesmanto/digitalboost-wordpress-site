#!/bin/bash

check_aws_cli() {
	if ! command -v aws $> /dev/null; then
		echo "AWS CLI is not installed. Please install it before proceeding."
		return 1
	fi
}

check_aws_profile() {
	if [ -z "$AWS_PROFILE" ]; then
		echo "AWS profile environment variable is not set"
		return 1
	fi
}

create_ec2_instance() {
	# specicify the parameters for the EC2 instances
	instance_type="t2.micro"
	ami_id="ami-0cd59ecaf368e5ccf"
	count=1 # Number of instances to create
	region="us-east-1" # Rgion to create cloud resources
	subnet_id="subnet-0ad991f47d2a85d5b"

	# Create the EC@ intances
	aws ec2 run-instances \
		--image-id "$ami_id" \
		--instance-type $instance_type \
		--subnet-id $subnet_id \
		--count $count \
		--key-name my-key-pair

	# Check if the EC@ instances were created successfully
	if [[ $? -eq 0 ]]; then
		echo "EC2 instances created successfully."
	else
		echo "Failed to create EC2 instances."
	fi
}

check_aws_cli
check_aws_profile
create_ec2_instance