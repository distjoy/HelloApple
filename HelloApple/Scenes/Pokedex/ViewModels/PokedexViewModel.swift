import Foundation

@MainActor
final class PokedexViewModel: ObservableObject {
    enum ViewState {
        case idle
        case loading
        case loaded([Pokemon])
        case failed(Error)
    }

    @Published private(set) var state: ViewState = .idle

    private let fetchPokemonList: FetchPokemonListUseCase

    init(fetchPokemonList: FetchPokemonListUseCase) {
        self.fetchPokemonList = fetchPokemonList
    }

    func loadInitialData() {
        guard case .idle = state else { return }
        state = .loading

        Task {
            do {
                let pokemons = try await fetchPokemonList.execute(limit: 20, offset: 0)
                state = .loaded(pokemons)
            } catch {
                state = .failed(error)
            }
        }
    }
}
