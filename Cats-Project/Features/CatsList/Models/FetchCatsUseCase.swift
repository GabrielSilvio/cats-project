import Foundation

protocol FetchCatsUseCaseProtocol {
    func execute(skip: Int, limit: Int) async -> Result<[CatSummary], Error>
}

final class FetchCatsUseCase: FetchCatsUseCaseProtocol {
    private let repository: CatsRepositoryProtocol
    init(repository: CatsRepositoryProtocol = CatsRepository()) {
        self.repository = repository
    }
    
    func execute(skip: Int, limit: Int) async -> Result<[CatSummary], Error> {
        let result = await repository.getCats(skip: skip, limit: limit)
        switch result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let entities = try decoder.decode([CatEntity].self, from: data)
                let summaries = entities.map { entity in
                    CatSummary(
                        id: entity.id,
                        tags: entity.tags,
                        mimetype: entity.mimetype,
                        createdAt: entity.createdAt 
                    )
                }
                return .success(summaries)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
