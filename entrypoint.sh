#!/bin/sh -l

api=$1
org=$2
space=$3
user=$4
password=$5

echo "Logging in to cf api $api org $org and space $space"

echo ::set-output name=deploymentResult::"successful"
