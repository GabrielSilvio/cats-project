import Foundation
import SwiftUI

@MainActor
final class CatDetailViewModel: ObservableObject {
    @Published var uiModel: CatDetailUIModel?
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    private let useCase: FetchCatDetailUseCaseProtocol
    private let id: String
    
    init(id: String, useCase: FetchCatDetailUseCaseProtocol = FetchCatDetailUseCase()) {
        self.id = id
        self.useCase = useCase
    }
    
    func fetch() async {
        isLoading = true
        error = nil
        let result = await useCase.execute(id: id)
        switch result {
        case .success(let entity):
            self.uiModel = CatDetailUIModel(from: entity)
        case .failure(let err):
            self.error = err.localizedDescription
        }
        isLoading = false
    }
}
