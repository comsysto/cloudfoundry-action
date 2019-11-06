#!/bin/sh -l
unset processStatus

handleLoginFailed(){
 processStatus="Login failed"
 echo "$processStatus"
}


handleLoginSuccessful(){
  processStatus="Login successful"
  echo "$processStatus"
}

target(){
  cf target -o "$1" -s "$2"
}

api=$1
org=$2
space=$3
user=$4
password=$5

cf api "$api"

echo "Loggin in to cloudfoundry at $api"

authenticationResult=$(cf auth "$user" "$password")
case "$authenticationResult" in
 *OK*)
   handleLoginSuccessful && target "$org" "$space"
   ;;
 *)
   handleLoginFailed
   ;;
esac

::set-output name=deploymentResult::"$processStatus"


