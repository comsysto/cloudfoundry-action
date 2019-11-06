#!/bin/sh -l

echo "Logging in to cf api $1 org $2 and space $3"

echo ::set-output name=deploymentResult::"successful"
