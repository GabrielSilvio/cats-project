import SwiftUI

struct CatsListView: View {
    @ObservedObject var viewModel: CatsListViewModel
    var onSelect: (CatSummary) -> Void

    var body: some View {
        List {
            ForEach(viewModel.rows) { row in
                CatRowView(uiModel: row)
                    .onTapGesture { onSelect(row.summary) }
                    .onAppear {
                        if row == viewModel.rows.last {
                            Task { await viewModel.loadNextPage() }
                        }
                    }
            }
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .listStyle(.plain)
        .refreshable { await viewModel.refresh() }
        .animation(.default, value: viewModel.rows)
    }
}

#Preview("Cats List") {
    NavigationStack {
        CatsListPreview()
            .navigationTitle("Cats")
    }
}

@MainActor
struct CatsListPreview: View {
    @StateObject private var viewModel: CatsListViewModel
    
    init() {
        let repository = CatsRepositoryMock()
        let useCase = FetchCatsUseCase(repository: repository)
        self._viewModel = StateObject(wrappedValue: CatsListViewModel(useCase: useCase))
    }
    
    var body: some View {
        CatsListView(viewModel: viewModel) { _ in }
            .onAppear {
                Task {
                    await viewModel.loadNextPage()
                }
            }
    }
}
