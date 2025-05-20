# 🐱 Cats Project

A modern iOS application built with SwiftUI, MVVM+C, and Clean Architecture, consuming the CatAAS API to display cats with animations, grid layout, detailed views, and decoupled navigation. This project demonstrates advanced iOS engineering practices suitable for professional environments.

## Features
- Paginated grid list of cats
- Detailed view for each cat (presented as a modal sheet)
- Pull-to-refresh for the cat list
- Animated transitions and modern UI
- Tag display, creation date, mimetype, and cat ID
- All presentation logic centralized in UIModels
- Robust error and loading state handling

## Architecture
This project follows a clean MVVM+C (Model-View-ViewModel + Coordinator) and Clean Architecture approach:

- **Coordinators**: Manage navigation flow and dependency injection
- **ViewModels**: Contain business and presentation logic
- **Views**: SwiftUI components for UI rendering
- **UseCases**: Encapsulate business rules and application logic
- **Repositories**: Abstract data sources for use cases
- **UIModels**: Centralize all presentation formatting and fallback logic

### Folder Structure
```
Cats-Project/
├── App/                  # App entry point and main coordinator
├── Features/             # Features organized by domain
│   └── CatsList/         # Cat list feature (grid, list, etc.)
│   └── CatDetails/       # Cat detail feature (modal, detail, etc.)
│       ├── Models/       # Data models, UIModels, Entities
│       ├── ViewModels/   # ViewModels for each feature
│       ├── Views/        # SwiftUI Views and subviews
│       └── Coordinators/ # Coordinators for navigation
├── Resources/            # Assets and resources
└── Shared/               # Shared components (e.g., Networking, Helpers)
```

## Dependencies
- **Swift 5.9+**
- **Xcode 15+**
- **SwiftUI**
- **Kingfisher** (for image caching)
- **XCTest** (for unit testing)
- **Async/Await** (for concurrency)

## Setup & Running
1. Clone the repository
2. Open `Cats-Project.xcodeproj` in Xcode 15 or newer
3. Select an iOS simulator or device
4. Run the project with `Cmd + R`

## Testing
- Uses **XCTest** only (no external test dependencies)
- Unit tests for `CatDetailUIModel` and `CatDetailViewModel`
- Test coverage includes:
  - UIModel construction (with/without tags, fallback logic)
  - ViewModel states: loading, error, success
- To run tests:
  1. Open the project in Xcode
  2. Select the test target
  3. Press `Cmd + U` or go to Product > Test

## Professional Notes
- Follows SOLID principles and Clean Architecture
- Dependency injection is used throughout for testability and modularity

---
