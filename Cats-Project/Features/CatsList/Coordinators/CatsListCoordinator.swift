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
        @State private var path = NavigationPath()
        @StateObject private var viewModel: CatsListViewModel

        init(useCase: FetchCatsUseCaseProtocol) {
            _viewModel = StateObject(wrappedValue: CatsListViewModel(useCase: useCase))
        }

        var body: some View {
            NavigationStack(path: $path) {
                CatsListView(viewModel: viewModel) { summary in
                    path.append(summary)
                }
                .navigationDestination(for: CatSummary.self) { summary in
                    CatDetailCoordinator(summary: summary).start()
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
