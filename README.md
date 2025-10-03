# HelloApple iOS Project Overview for Android Engineers

This document breaks down the structure of the `codex/create-ios-project-structure-for-pokemon-app/HelloApple` branch and highlights the parallels you can draw if you come from an Android background.

## High-level Goals
- Provide a minimal SwiftUI-based starter app that mirrors the "Hello World" setup you might create with Jetpack Compose.
- Establish an entry point for future Pokémon-themed features (currently placeholders).
- Keep the structure small so it is easy to hook into existing cross-platform tooling (CI, linting, etc.).

## Repository Layout
| Path | iOS Concept | Android Analogy | Notes |
|------|-------------|-----------------|-------|
| `HelloApple/HelloAppleApp.swift` | App entry point defined with the `@main` attribute. | `Application` class + first `Activity`/`Composable` entry point. | Sets up the root scene with `ContentView`. |
| `HelloApple/ContentView.swift` | Root `View` rendered in the main window using SwiftUI. | Jetpack Compose `@Composable` that returns UI. | Currently shows a system SF Symbol and "Hello, world!" text; good place to start injecting feature screens. |
| `HelloApple/Assets.xcassets` | Catalog for images, colors, etc. managed by Xcode. | `res/drawable`, `res/color`, etc. | Populate this with Pokémon artwork or theme colors later. |
| `HelloApple.xcodeproj` | Xcode project file storing build settings, targets, and scheme metadata. | Gradle module configuration (`*.gradle.kts`) + `.idea` project files. | Usually edited via Xcode rather than manually. |

> **Tip:** If you are using VS Code or AppCode, rely on Xcode once to create schemes or change bundle identifiers; the `.xcodeproj` holds those settings.

## Key SwiftUI Concepts for Android Developers
- **`@main` App struct**: Similar to declaring `Application` + root `Activity`. The `body` returns a `Scene`, and `WindowGroup` is comparable to the top-level Compose `setContent { ... }` call.
- **`View` structs**: SwiftUI views are immutable structs. `ContentView` mirrors a Compose function annotated with `@Composable`. Instead of modifiers like `Modifier.padding(16.dp)`, SwiftUI chains view modifiers like `.padding()`.
- **Previews**: The `#Preview` block at the bottom of `ContentView.swift` is SwiftUI's equivalent of Android Studio's `@Preview` composable. It renders live previews inside Xcode.

## Build & Run
1. Open `HelloApple.xcodeproj` in Xcode 15+.
2. Select the `HelloApple` scheme (created automatically).
3. Choose an iOS Simulator (e.g., iPhone 15) and press **Run** (`⌘R`).

There is no dependency manager configured yet (no CocoaPods/Swift Package Manager packages). Everything compiles with the standard toolchain.

## Next Steps for Feature Work
- Replace `ContentView` with a Pokémon-themed home screen. Consider splitting it into subviews (`PokemonListView`, `PokemonDetailView`) similar to Compose composables.
- Add models and networking by introducing new Swift files under `HelloApple/` (akin to creating Kotlin packages). You can create folders via Xcode; they map to groups/namespaces.
- Configure assets and app icons inside `Assets.xcassets` once designs are ready.
- Integrate tests by adding a `HelloAppleTests` target through Xcode's "New Target" flow (similar to setting up `androidTest`/`test` source sets).

## Tooling Parallels
- **Swift Package Manager (SPM)** will likely serve the role Gradle plays for dependency management when third-party packages are introduced.
- **Xcode Schemes** are analogous to Gradle build variants/flavors. Currently there is a single default scheme.
- **CI/CD**: Use `xcodebuild` or `fastlane` as rough equivalents to Gradle CLI when you need automation.

Armed with these analogies, an Android engineer should be able to navigate and extend this iOS starter project with minimal friction.
