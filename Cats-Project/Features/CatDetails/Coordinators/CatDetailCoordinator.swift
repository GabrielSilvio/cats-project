import SwiftUI

@MainActor
struct CatDetailCoordinator: Coordinator {
    let summary: CatSummary
    @Namespace private var animation
    @State private var showDetail: Bool = true
    
    func start() -> some View {
        CatDetailCoordinatorView(summary: summary, animation: animation)
    }
}

private struct CatDetailCoordinatorView: View {
    let summary: CatSummary
    var animation: Namespace.ID
    @State private var show: Bool = true
    
    var body: some View {
        CatDetailView(
            uiModel: CatDetailAnimatedModel(from: summary),
            animation: animation,
            show: $show
        )
    }
}
