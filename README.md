# sample-xcodegen-app

Minimal monorepo-style iOS app whose Xcode project is generated with
[XcodeGen](https://github.com/yonaskolb/XcodeGen) instead of being committed.

It mirrors the shape of real-world make + XcodeGen monorepos:

- `ios/project.yml` is the project source of truth; `ios/SampleApp.xcodeproj`
  is gitignored, generated output
- `make layers` generates a local Swift package (`ios/GeneratedKit`) from
  config living outside `ios/` (`shared/config/app.yaml`), symlinks a shared
  Swift source into it, and stamps the current git commit
- `make project` runs `layers` and then `xcodegen generate`

## Build locally

```sh
make project
xcodebuild -project ios/SampleApp.xcodeproj -scheme SampleApp \
  -destination 'generic/platform=iOS Simulator' build
```

## Build on Limrun

`limrun.yaml` declares the project location and the prepare commands, so a
plain build command is enough:

```sh
lim xcode build
```
