import SwiftUI

@MainActor
protocol Coordinator {
    associatedtype Body: View
    func start() -> Body
}

@MainActor
final class AppCoordinator: ObservableObject, Coordinator {
    private let rootCoordinator: CatsListCoordinator
    
    init(rootCoordinator: CatsListCoordinator) {
        self.rootCoordinator = rootCoordinator
    }
    
    func start() -> some View {
        return rootCoordinator.start()
    }
}
