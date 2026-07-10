import SwiftUI

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 12) {
                Text("XcodeGen Sample")
                    .font(.title)
                Text("Generated with XcodeGen, built on Limrun")
                    .font(.footnote)
            }
        }
    }
}
