import Foundation

protocol CatsAPIServiceProtocol {
    func fetchCats(skip: Int, limit: Int) async throws -> [CatSummary]
}

final class CatsAPIService: CatsAPIServiceProtocol {
    private let baseURL = "https://cataas.com"
    func fetchCats(skip: Int, limit: Int) async throws -> [CatSummary] {
        guard let url = URL(string: "\(baseURL)/api/cats?skip=\(skip)&limit=\(limit)") else {
            return []
        }
        return try await NetworkClient.shared.get(url: url)
    }
}