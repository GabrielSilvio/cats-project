import SwiftUI

@main
struct Cats_ProjectApp: App {
    @StateObject private var coordinator = AppCoordinator(rootCoordinator: CatsListCoordinator())
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}

#Preview {
    let repository = CatsRepositoryMock()
    let useCase = FetchCatsUseCase(repository: repository)
    let coordinator = AppCoordinator(rootCoordinator: CatsListCoordinator(useCase: useCase))
    return coordinator.start()
}
