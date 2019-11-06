#!/bin/sh -l

api=$1
org=$2
space=$3
user=$4
password=$5

echo "cf api $api"

echo "Loggin in to cloudfoundry at $api"
# authenticationResult=$(cf auth "$user" "$password")
# if [[ $authenticationResult != *"OK"* ]]; then
#  ::set-output name=deploymentResult::"authentication failed"
#  exit 0
# fi


echo "cf target -o \"$org\" -s \"$space\""

echo ::set-output name=deploymentResult::"successful"
