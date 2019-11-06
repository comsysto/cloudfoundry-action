#!/bin/sh -l
unset processStatus

api=$1
org=$2
space=$3
user=$4
password=$5
artifactDir=$6

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

deploy(){
  echo "Deploying ..."
  mv "$artifactDir/*" .

  artifactName=$(find . -name '*.jar')

  processStatus=$(cf push -f "$artifactName" --no-start)
}



cf api "$api"

echo "Loggin in to cloudfoundry at $api"

authenticationResult=$(cf auth "$user" "$password")
case "$authenticationResult" in
 *OK*)
   handleLoginSuccessful && target "$org" "$space" && deploy
   ;;
 *)
   handleLoginFailed
   ;;
esac

echo ::set-output name=deploymentResult::"$processStatus"


