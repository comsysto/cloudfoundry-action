# Cloudfoundry Action - auth

The `cf auth` has to be wrapped slightly different than how other cf [cli](../cli/README.md) commands are wrapped, since there are currently some issues with passing credentials to the [cli](../cli/README.md).

This is the only reason for the existence of this (sub) action. We'll probably get rid of the [auth]() action in a future release and support authentication with [cli](../cli/README.md) only.
