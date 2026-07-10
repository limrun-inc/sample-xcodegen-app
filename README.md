# sample-xcodegen-app

Minimal iOS app whose Xcode project is generated with
[XcodeGen](https://github.com/yonaskolb/XcodeGen) instead of being committed:
`project.yml` is the source of truth and `SampleApp.xcodeproj` is gitignored.

## Build locally

```sh
xcodegen generate
xcodebuild -project SampleApp.xcodeproj -scheme SampleApp \
  -destination 'generic/platform=iOS Simulator' build
```

## Build on Limrun

```sh
lim xcode build .
```

No configuration needed: Limrun detects `project.yml`, runs XcodeGen on the
build instance, and builds the generated project.
