import SwiftUI

@MainActor
struct CatDetailCoordinator: Coordinator {
    let id: String
    @State private var showDetail: Bool = true
    
    func start() -> some View {
        CatDetailCoordinatorView(id: id)
    }
}

private struct CatDetailCoordinatorView: View {
    let id: String
    @State private var show: Bool = true
    @StateObject private var viewModel: CatDetailViewModel
    
    init(id: String) {
        self.id = id
        _viewModel = StateObject(wrappedValue: CatDetailViewModel(id: id))
    }
    
    var body: some View {
        CatDetailView(
            viewModel: viewModel
        )
    }
}
