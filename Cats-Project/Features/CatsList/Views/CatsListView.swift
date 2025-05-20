import SwiftUI
import Kingfisher

struct CatsListView: View {
    @ObservedObject var viewModel: CatsListViewModel
    var onSelect: (CatSummary) -> Void
    @Namespace private var animation
    @State private var selectedCat: CatSummary?
    @State private var showDetail = false

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.cats) { cat in
                        let uiModel = CatRowUIModel(from: cat)
                        CatGridItemView(uiModel: uiModel, animation: animation, isSource: !showDetail)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    onSelect(cat)
                                }
                            }
                            .onAppear {
                                if cat == viewModel.cats.last {
                                    Task { await viewModel.loadNextPage() }
                                }
                            }
                    }
                }
                .padding()
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .refreshable { await viewModel.refresh() }
            .animation(.easeInOut, value: viewModel.cats)
            .blur(radius: showDetail ? 20 : 0)
            .disabled(showDetail)
        }
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
