# helm-library-chart

A [Helm Library Chart](https://helm.sh/docs/topics/library_charts/) used as the basis for all of [my Helm Chart implementations](https://github.com/justingarfield/helm-charts).

## Differences from K8s-at-home Library Chart

* Removed template functions that I won't be needing
  * addons: promtail
  * addons: codeserver
  * addons: openvpn
* Refactored and renamed certain template functions
* Split-out Unit and Integration Tests into separate test charts
* Got rid of _incubator/stable_ concept and just have library chart in root
* Different `.ci` directory layout
* Using own custom version of `chart-releaser-action` to release single chart in root
* Using _helm3-unittest_ fork [quintush/helm-unittest](https://github.com/quintush/helm-unittest) instead of [vbehar/helm3-unittest](https://github.com/vbehar/helm3-unittest)

## Development

See [docs/development.md](docs/development.md)

## Automated Testing

See [docs/automated-testing.md](docs/automated-testing.md)

## References

See [docs/docs-and-references.md](docs/docs-and-references.md)

## Credit

A huge thanks to the [K8s-at-home](https://github.com/k8s-at-home) community for an awesome starting foundation and influencing the creation of this library chart.

## Disclaimers

I do not offer any assistance or support for others that decide to clone / fork source from this repository. I'm providing this publicly as a way to share thoughts and ideas around how folks can work with Helm, based-upon what I'm actively consuming for my own home use. I work on Linux and Windows environments exclusively, so this project will not contain files or support for macOS.
