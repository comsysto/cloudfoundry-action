#!/bin/sh -l

api=$1
user=$2
password=$3

echo "Loggin in to cloudfoundry at $api"
cf api "$api"
echo ::set-output name=authResult::"$(cf auth "$user" "$password")"
# authenticationResult="$(cf auth "$user" "$password")"
# case "$authenticationResult" in
#  *OK*)
#    echo ::set-output name=authResult::"$(cf auth "$user" "$password")"
#    ;;
#  *)
#    echo ::set-output name=authResult::"Login failed"
#    exit 1
#    ;;
# esac




