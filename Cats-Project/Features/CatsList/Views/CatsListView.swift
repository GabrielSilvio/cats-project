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
                    ForEach(viewModel.rows) { row in
                        CatGridItemView(uiModel: row, animation: animation, isSource: !showDetail)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    selectedCat = row.summary
                                    showDetail = true
                                }
                            }
                            .onAppear {
                                if row == viewModel.rows.last {
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
            .animation(.easeInOut, value: viewModel.rows)
            .blur(radius: showDetail ? 20 : 0)
            .disabled(showDetail)

            if let selected = selectedCat, showDetail {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                CatDetailAnimatedView(summary: selected, animation: animation, show: $showDetail)
                    .zIndex(1)
            }
        }
    }
}

struct CatGridItemView: View {
    let uiModel: CatRowUIModel
    var animation: Namespace.ID
    var isSource: Bool

    var body: some View {
        VStack(spacing: 8) {
            KFImage(uiModel.thumbnailURL)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .matchedGeometryEffect(id: uiModel.id, in: animation, isSource: isSource)
                .shadow(radius: 6)
            Text(uiModel.mainTag)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
            Text(uiModel.createdAtText)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        )
        .scaleEffect(0.98)
        .animation(.spring(), value: uiModel.id)
    }
}

struct CatDetailAnimatedView: View {
    let summary: CatSummary
    var animation: Namespace.ID
    @Binding var show: Bool

    var body: some View {
        VStack {
            KFImage(URL(string: "https://cataas.com/cat/\(summary.id)"))
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .matchedGeometryEffect(id: summary.id, in: animation, isSource: show)
                .shadow(radius: 10)
                .padding(.top, 40)
            Text(summary.tags.first?.capitalized ?? "Cat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            Text(DateFormatterHelper.formatISO8601String(summary.createdAt, dateStyle: .full, timeStyle: .short))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
            Spacer()
            Button(action: {
                withAnimation(.spring()) {
                    show = false
                }
            }) {
                Text("Close")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(.systemBackground))
                .shadow(radius: 20)
        )
        .padding(.horizontal, 24)
        .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
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
