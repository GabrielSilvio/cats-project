import Foundation

protocol FetchCatDetailUseCaseProtocol {
    func execute(id: String) async -> Result<CatDetailEntity, Error>
}

final class FetchCatDetailUseCase: FetchCatDetailUseCaseProtocol {
    private let repository: CatDetailRepositoryProtocol
    init(repository: CatDetailRepositoryProtocol = CatDetailRepository()) {
        self.repository = repository
    }
    
    func execute(id: String) async -> Result<CatDetailEntity, Error> {
        await repository.getCatDetail(id: id)
    }
} 