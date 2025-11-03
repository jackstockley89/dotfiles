#!/bin/bash

# This script rotates the access key for the specified IAM user.

# Usage: ./rotate-access-key.bash

# The IAM username and Email is passed as an argument to the script via a read command.

# The script performs the following steps:
# 1. Create a new access key for the specified IAM user.
# 2. Delete the old access key for the specified IAM user.
# 3. Send the new access key to the specified email address.

# Check if the IAM user name is passed as an argument to the script.
if [ -z "$1" ]; then
	echo "Usage: rotate-access-key.bash <IAM-USER-NAME>"
	exit 1
fi

# Get the IAM user name from the argument.
read -p "IAM user to be rotated: " IAM_USER_NAME

# Check if the IAM user exists.
aws iam get-user --user-name $IAM_USER_NAME >/dev/null
if [ $? -ne 0 ]; then
	echo "IAM user $IAM_USER_NAME does not exist."
	exit 1
fi

# List the access keys for the specified IAM user.
aws iam list-access-keys --user-name $IAM_USER_NAME
if [ $? -ne 0 ]; then
	echo "Failed to list access keys for the IAM user."
	exit 1
fi

# Set Current access key to old access key
OLD_ACCESS_KEY=$(aws iam list-access-keys --user-name $IAM_USER_NAME | jq -r '.AccessKeyMetadata[0].AccessKeyId')

# Create a new access key for the specified IAM user.
aws iam create-access-key --user-name $IAM_USER_NAME
if [ $? -ne 0 ]; then
	echo "Failed to create a new access key for the IAM user."
	exit 1
fi

# Delete the old access key for the specified IAM user.
aws iam delete-access-key --user-name $IAM_USER_NAME --access-key-id $OLD_ACCESS_KEY
if [ $? -ne 0 ]; then
	echo "Failed to delete the old access key for the IAM user."
	exit 1
fi

echo $($(aws iam list-access-keys --user-name $IAM_USER_NAME | jq -r '.AccessKeyMetadata[0].AccessKeyId')) >/tmp/Access_Key.txt
echo $($(aws iam list-access-keys --user-name $IAM_USER_NAME | jq -r '.AccessKeyMetadata[0].SecretAccessKey')) >/tmp/Secret_Access_Key.txt

read -p "Email required to update user of rotated key( access key and secret will be sent in seprate emails ): " EMAIL

mail -s "Key Rotation" -a /tmp/Access_Key.txt $EMAIL
mail -s "Key Rotation" -a /tmp/Secret_Access_Key.txt $EMAIL

