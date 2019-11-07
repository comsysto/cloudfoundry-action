#!/bin/sh
set -e

api=$1
user=$2
password=$3

cf api "$api"
cf auth "$user" "$password"





