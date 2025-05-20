import Foundation

@MainActor
final class CatsListViewModel: ObservableObject {
    @Published private(set) var rows: [CatRowUIModel] = []
    @Published var isLoading = false

    private let useCase: FetchCatsUseCaseProtocol
    private var skip = 0
    private let limit = 10
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
            let newRows = cats.map { CatRowUIModel(from: $0) }
            rows.append(contentsOf: newRows)
            skip += 1
        case .failure:
            finished = true
        }
    }

    func refresh() async {
        skip = 0
        finished = false
        rows = []
        await loadNextPage()
    }
}
