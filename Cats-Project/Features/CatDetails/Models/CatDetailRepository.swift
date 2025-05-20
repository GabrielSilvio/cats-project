import Foundation

protocol CatDetailRepositoryProtocol {
    func getCatDetail(id: String) async -> Result<CatDetailEntity, Error>
}

final class CatDetailRepository: CatDetailRepositoryProtocol {
    func getCatDetail(id: String) async -> Result<CatDetailEntity, Error> {
        guard let url = URL(string: "https://cataas.com/cat/\(id)?json=true") else {
            return .failure(URLError(.badURL))
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
                return .failure(URLError(.badServerResponse))
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let entity = try decoder.decode(CatDetailEntity.self, from: data)
            return .success(entity)
        } catch {
            return .failure(error)
        }
    }
} 