import SwiftUI

@main
struct HelloAppleApp: App {
    private let container = AppDependencyContainer()

    var body: some Scene {
        WindowGroup {
            PokedexView(viewModel: container.makePokedexViewModel())
        }
    }
}
