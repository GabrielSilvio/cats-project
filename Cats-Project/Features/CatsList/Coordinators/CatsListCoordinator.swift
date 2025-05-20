import SwiftUI

@MainActor
struct CatsListCoordinator: Coordinator {
    private let useCase: FetchCatsUseCaseProtocol

    init(useCase: FetchCatsUseCaseProtocol = FetchCatsUseCase()) {
        self.useCase = useCase
    }

    func start() -> some View {
        CatsListFlow(useCase: useCase)
    }

    private struct CatsListFlow: View {
        @State private var selectedCat: CatSummary?
        @StateObject private var viewModel: CatsListViewModel

        init(useCase: FetchCatsUseCaseProtocol) {
            _viewModel = StateObject(wrappedValue: CatsListViewModel(useCase: useCase))
        }

        var body: some View {
            NavigationStack {
                CatsListView(viewModel: viewModel) { summary in
                    selectedCat = summary
                }
                .sheet(item: $selectedCat) { summary in
                    CatDetailCoordinator(id: summary.id).start()
                }
            }
            .onAppear {
                Task { @MainActor in
                    await viewModel.loadNextPage()
                }
            }
        }
    }
}
