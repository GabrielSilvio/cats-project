import Foundation

@MainActor
final class CatsListViewModel: ObservableObject {
    @Published private(set) var cats: [CatSummary] = []
    @Published var isLoading = false

    private let useCase: FetchCatsUseCaseProtocol
    private var skip = 0
    private let limit = 20
    private var finished = false

    init(useCase: FetchCatsUseCaseProtocol = FetchCatsUseCase()) {
        self.useCase = useCase
    }

    func loadNextPage() async {
        guard !isLoading && !finished else { return }
        isLoading = true
        defer { isLoading = false }
        let result = await useCase.execute(skip: skip, limit: limit)
        switch result {
        case .success(let cats):
            if cats.isEmpty { finished = true; return }
            self.cats.append(contentsOf: cats)
            skip += limit
        case .failure:
            finished = true
        }
    }

    func refresh() async {
        skip = 0
        finished = false
        cats = []
        await loadNextPage()
    }
}
