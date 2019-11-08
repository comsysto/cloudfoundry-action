# Cloudfoundry Action

Authenticate to a cloudfoundry api and use the cli with the github workflow dsl.

## Structure
The repo is separated into basically two actions:

* [auth](auth/README.md)
* [cli](cli/README.md)

In a future release we might reduce it to [cli](cli/README.md) only, 
but since there are some issues with passing credentials to the [cli](cli/README.md), the authentication is done by facilitating [auth](auth/README.md).

## Example usage

```
name: Couldfoundry Deployment
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 11
      - name: Build with Gradle
        run: ./gradlew clean build
      - name: Login to cloudfoundry
        uses: comsysto/cloudfoundry-action/auth@release
        with:
          api: '<the-cf-api-of-your-choice>'
          user: ${{ secrets.CF_USERNAME }}
          password: ${{ secrets.CF_PASSWORD }}
      - name: cf target -o mvg -s development
        uses: comsysto/cloudfoundry-action/cli@release
        with:
          args: target -o '<the-org-of-your-choice>' -s '<the-space-of-your-choice>'
      - name: cf push
        uses: comsysto/cloudfoundry-action/cli@release
        with:
          args: push -f <path-to-the-manifest-file> -p <path-to-the-artifact-to-deploy>
```
## Projects that uses the the cloudfoundry-action


## Sources:

* [How to create a new repository based on a template](https://github.blog/2019-06-06-generate-new-repositories-with-repository-templates/)

* [How to build a container action](https://github.com/actions/toolkit/blob/master/docs/container-action.md)
