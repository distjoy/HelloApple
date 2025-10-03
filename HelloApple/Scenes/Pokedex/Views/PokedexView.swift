import SwiftUI

struct PokedexView: View {
    @StateObject private var viewModel: PokedexViewModel

    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Pokédex")
        }
        .task {
            viewModel.loadInitialData()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading Pokémon...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let pokemons):
            List(pokemons) { pokemon in
                HStack {
                    Text(pokemon.name)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
            }
        case .failed:
            ContentUnavailableView(
                "Unable to load Pokémon",
                systemImage: "exclamationmark.triangle",
                description: Text("Check your connection and try again.")
            )
        }
    }
}

#Preview {
    PokedexView(viewModel: PokedexViewModel(fetchPokemonList: FetchPokemonListUseCase(repository: PreviewPokemonRepository())))
}

private struct PreviewPokemonRepository: PokemonRepository {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon] {
        [
            Pokemon(name: "Bulbasaur", detailURL: nil),
            Pokemon(name: "Charmander", detailURL: nil),
            Pokemon(name: "Squirtle", detailURL: nil)
        ]
    }
}
