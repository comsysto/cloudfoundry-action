# Cloud Foundry Action - auth

The `cf auth` has to be wrapped slightly different than how other cf [cli](../cli/README.md) commands are wrapped, since there are currently some issues with passing credentials to the [cli](../cli/README.md).

This is the only reason for the existence of this (sub) action. We'll probably get rid of the [auth]() action in a future release and support authentication with [cli](../cli/README.md) only.

## Example usage
```
...
- name: Login to cloudfoundry
  uses: comsysto/cloudfoundry-action/auth@v1.0
  with:
    api: '<the-cf-api-of-your-choice>'
    user: ${{ secrets.CF_USERNAME }}
    password: ${{ secrets.CF_PASSWORD }}
...
```

A more complete example can be found in the [root README.md](../README.md).
