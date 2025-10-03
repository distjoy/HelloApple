import Foundation

/// Abstraction for performing network requests.
protocol APIClient {
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T
}

/// Default implementation backed by `URLSession`.
struct URLSessionAPIClient: APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}

enum APIError: Error {
    case invalidResponse
    case decoding(Error)
}
