import Foundation

/// Coordinates retrieving a page of Pokémon for presentation.
struct FetchPokemonListUseCase {
    private let repository: PokemonRepository

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(limit: Int, offset: Int) async throws -> [Pokemon] {
        try await repository.fetchPokemonList(limit: limit, offset: offset)
    }
}
