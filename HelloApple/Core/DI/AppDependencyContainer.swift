import Foundation

/// A simple dependency container that wires up core services and view models.
struct AppDependencyContainer {
    private let pokemonAPIService: PokemonAPIService
    private let pokemonRepository: PokemonRepository

    init() {
        let apiClient = URLSessionAPIClient()
        self.pokemonAPIService = RemotePokemonAPIService(apiClient: apiClient)
        self.pokemonRepository = RemotePokemonRepository(service: pokemonAPIService)
    }

    func makePokedexViewModel() -> PokedexViewModel {
        let fetchPokemonListUseCase = FetchPokemonListUseCase(repository: pokemonRepository)
        return PokedexViewModel(fetchPokemonList: fetchPokemonListUseCase)
    }
}
