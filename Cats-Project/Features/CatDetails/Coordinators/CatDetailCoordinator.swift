import SwiftUI

@MainActor
struct CatDetailCoordinator: Coordinator {
    let summary: CatSummary
    func start() -> some View {
        CatDetailView(viewModel: CatDetailViewModel(summary: summary))
    }
}
