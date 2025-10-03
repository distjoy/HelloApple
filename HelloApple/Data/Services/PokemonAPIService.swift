import Foundation

/// Describes the remote API used to retrieve Pokémon data.
protocol PokemonAPIService {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListDTO
}

struct RemotePokemonAPIService: PokemonAPIService {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListDTO {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!
        let request = URLRequest(url: url)
        return try await apiClient.perform(request)
    }
}

struct PokemonListDTO: Decodable {
    let results: [PokemonSummaryDTO]
}

struct PokemonSummaryDTO: Decodable {
    let name: String
    let url: String
}
