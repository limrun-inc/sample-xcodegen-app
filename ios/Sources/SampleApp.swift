import SwiftUI
import GeneratedKit

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 12) {
                Text("XcodeGen Sample")
                    .font(.title)
                Text(Generated.buildInfo)
                    .font(.footnote)
            }
        }
    }
}
