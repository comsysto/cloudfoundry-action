# Cloud Foundry Action - cli


This action is simply a wrapper around the cf CLI. Every parameter passed to the action in the args section will be executed with `cf $*`.

## Example usage
```
...
- name: switch cf space
  uses: comsysto/cloudfoundry-action/cli@v1.0
  with:
    args: target -o '<the-org-of-your-choice>' -s '<the-space-of-your-choice>'
...
```

A more complete example can be found in the [root README.md](../README.md).
