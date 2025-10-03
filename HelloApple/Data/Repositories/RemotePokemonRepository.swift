import Foundation

struct RemotePokemonRepository: PokemonRepository {
    private let service: PokemonAPIService

    init(service: PokemonAPIService) {
        self.service = service
    }

    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon] {
        let dto = try await service.fetchPokemonList(limit: limit, offset: offset)
        return dto.results.map { Pokemon(name: $0.name.capitalized, detailURL: URL(string: $0.url)) }
    }
}
