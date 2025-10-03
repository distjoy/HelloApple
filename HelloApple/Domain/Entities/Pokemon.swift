import Foundation

struct Pokemon: Identifiable {
    let id = UUID()
    let name: String
    let detailURL: URL?
}
