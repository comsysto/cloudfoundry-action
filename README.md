# Cloud Foundry Action

A GitHub Docker action to authenticate to a Cloud Foundry API and use the CLI with the GitHub workflow DSL.

Supporting [Cloud Foundry CLI v6.47.2](https://github.com/cloudfoundry/cli/releases/tag/v6.47.2) commands.

## Structure
The repository is separated into two actions:

* [auth](auth/README.md)
* [cli](cli/README.md)

In a future release we might reduce it to [cli](cli/README.md) only, 
but since there are some issues with passing credentials to the [cli](cli/README.md), the authentication is done by facilitating [auth](auth/README.md).

## Keep your credentials encrypted

GitHub provides the feature to [store credentials encrypted](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets#creating-encrypted-secrets) 
in the settings section of the repository you want to create a [workflow](https://help.github.com/en/actions/automating-your-workflow-with-github-actions).
Once configured, any configured secret is available in your workflow by referencing `${{ secrets.<secretName> }}`.
## Example usage

```
name: Could Foundry Deployment
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
        uses: comsysto/cloudfoundry-action/auth@v1.0
        with:
          api: '<the-cf-api-of-your-choice>'
          user: ${{ secrets.CF_USERNAME }}
          password: ${{ secrets.CF_PASSWORD }}
      - name: Switch to cf org and space
        uses: comsysto/cloudfoundry-action/cli@v1.0
        with:
          args: target -o '<the-org-of-your-choice>' -s '<the-space-of-your-choice>'
      - name: cf push
        uses: comsysto/cloudfoundry-action/cli@v1.0
        with:
          args: push -f <path-to-the-manifest-file> -p <path-to-the-artifact-to-deploy>
```
## Projects that uses the the cloudfoundry-action

* https://github.com/comsysto/github-action-lab

## Sources:

* [Official workflow documentation](https://help.github.com/en/actions/automating-your-workflow-with-github-actions)

* [How to create a new repository based on a template](https://github.blog/2019-06-06-generate-new-repositories-with-repository-templates/)

* [How to build a container action](https://github.com/actions/toolkit/blob/master/docs/container-action.md)

* [gcloud action](https://github.com/actions/gcloud)
