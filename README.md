# 🐱 Cats Project

A modern iOS app that displays cats using the CatAAS API (Cat as a Service). This project was developed following the MVVM+C architecture (Model-View-ViewModel + Coordinator) with proper Swift concurrency usage.

## 📱 Features

- List of cats with pagination
- Selected cat details
- Pull-to-refresh to update the list
- Coordinated navigation between screens
- Actor isolation with @MainActor to ensure concurrency safety

## 🏗️ Architecture

This project follows a clean MVVM+C architecture:

### 📂 Folder structure:

```
Cats-Project/
├── App/                  # App entry point and main coordinator
├── Features/             # Features organized by domain
│   └── Cats/             # Specific feature (cats)
│       ├── Data/         # Data layer
│       │   ├── Model/    # Data models
│       │   └── Repository/# Repositories
│       ├── Domain/       # Domain layer
│       │   └── UseCases/ # Use cases
│       └── Presentation/ # Presentation layer
│           ├── Coordinators/ # Coordinators
│           ├── UIModels/     # UI Models
│           ├── ViewModels/   # View Models
│           └── Views/        # SwiftUI Views
└── Shared/              # Shared components
    └── Networking/      # Network layer
```

### 🧩 Main components:

- **Coordinators**: Manage navigation flow and dependency injection
- **ViewModels**: Contain business logic for views
- **Views**: SwiftUI components that display the user interface
- **UseCases**: Encapsulate specific business rules
- **Repositories**: Abstract the data source for use cases

## 🛠️ Technologies used

- Swift 5.9+
- SwiftUI
- Async/Await for asynchronous operations
- @MainActor for concurrency isolation
- Dependency injection via initializers
- REST API (CatAAS)

## 🚀 How to run

1. Clone the repository
2. Open the project in Xcode 15+
3. Select an iOS simulator or device
4. Run the project (⌘+R)

## 📝 Notes

This project was developed following SOLID principles and Clean Architecture to demonstrate software engineering skills in a technical interview.