# Automated Testing

I attempted to do my best to separate Unit and Integration tests from each other. There's a bit of overlap in some areas as the library stands at this point in time. Further refactoring is required at this point to do a 100% pure separation.

## Unit Tests

All Unit Test templates contain metadata.name to appease the helm linter.

## Running Unit Tests

```shell

```

## Running Integration Tests

```shell

```

## Random Notes

* Not happy with current state of testing `additionalContainers` related items with sidecars

## Test Status

Notes to help me keep my sanity as to where the unit tests stand...

| File                                 | Status           | Notes                                       |
|-|-|
| `lib/chart/_annotations.tpl`         | Full Coverage    | |
| `lib/chart/_capabilities.tpl`        | Full Coverage    | |
| `lib/chart/_labels.tpl`              | Full Coverage    | |
| `lib/chart/_names.tpl`               | Full Coverage    | |
| `lib/chart/_values.tpl`              | No Coverage      | Still trying to figure out how to test this in a sane way |
| `lib/controller/_env-vars.tpl`       | Full Coverage    | |
| `lib/controller/_main-container.tpl` | Full Coverage    | |
| `lib/controller/_pod.tpl`            | Full Coverage    | |
| `lib/controller/_ports.tpl`          | Full Coverage    | |
| `lib/controller/_probes.tpl`         | No Coverage      | |
| `lib/controller/_volume-mounts.tpl`  | No Coverage      | |
| `lib/controller/_volumes.tpl`        | No Coverage      | |
| `lib/_configmap.tpl`                 | Full Coverage    | |
| `lib/_configmaps.tpl`                | No Coverage      | |
| `lib/_daemonset.tpl`                 | Partial Coverage | |
| `lib/_deployment.tpl`                | Partial Coverage | |
| `lib/_ingress.tpl`                   | No Coverage      | |
| `lib/_ingresses.tpl`                 | No Coverage      | |
| `lib/_kubernetes-manifest.tpl`       | No Coverage      | |
| `lib/_notes.tpl`                     | No Coverage      | |
| `lib/_persistent-volume-claim.tpl`   | No Coverage      | |
| `lib/_persistent-volume-claims.tpl`  | No Coverage      | |
| `lib/_secret.tpl`                    | Full Coverage    | |
| `lib/_service_ports.tpl`             | No Coverage      | |
| `lib/_service.tpl`                   | Partial Coverage | |
| `lib/_serviceaccount.tpl`            | Full Coverage    | |
| `lib/_services.tpl`                  | Partial Coverage | |
| `lib/_statefulset.tpl`               | Partial Coverage | |
