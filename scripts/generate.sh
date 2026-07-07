#!/bin/bash
# Generates a Swift package (Package.swift + sources) from config living
# outside ios/, stamps the current git commit, and symlinks shared sources
# into the generated package.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

APP_NAME="$(grep '^appName:' "$ROOT/shared/config/app.yaml" | cut -d' ' -f2)"
# Remote build sandboxes have no .git; Limrun exports GIT_COMMIT (captured
# client-side at sync time) to prepare commands. Prefer it, fall back to
# git for plain local runs.
GIT_SHA="${GIT_COMMIT:-$(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || echo "unknown")}"

KIT="$ROOT/ios/GeneratedKit"
mkdir -p "$KIT/Sources/GeneratedKit"

cat > "$KIT/Package.swift" <<EOF
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GeneratedKit",
    platforms: [.iOS(.v16)],
    products: [.library(name: "GeneratedKit", targets: ["GeneratedKit"])],
    targets: [.target(name: "GeneratedKit", path: "Sources/GeneratedKit")]
)
EOF

cat > "$KIT/Sources/GeneratedKit/Generated.swift" <<EOF
public enum Generated {
    public static let buildInfo = "app=$APP_NAME sha=$GIT_SHA greeting=\(SharedGreeting.text)"
}
EOF

ln -sfn ../../../../shared/swift/SharedGreeting.swift "$KIT/Sources/GeneratedKit/SharedGreeting.swift"

echo "generated GeneratedKit (app=$APP_NAME sha=$GIT_SHA)"
