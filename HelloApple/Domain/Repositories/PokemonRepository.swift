import Foundation

/// Abstraction that hides the data source for Pokémon entities.
protocol PokemonRepository {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon]
}
