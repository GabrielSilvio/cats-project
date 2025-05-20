import XCTest
import SwiftUI
@testable import Cats_Project

final class CatDetailUIModelTests: XCTestCase {
    func testUIModelWithTags() {
        // Given
        let entity = CatDetailEntity(id: "1", tags: ["cute", "black"], createdAt: "2024-06-20T12:00:00.000Z", url: "https://cataas.com/cat/1", mimetype: "image/jpeg")
        // When
        let sut = CatDetailUIModel(from: entity)
        // Then
        XCTAssertEqual(sut.tagsText, "cute, black")
        XCTAssertEqual(sut.tags, ["cute", "black"])
        XCTAssertTrue(sut.createdAtText.contains("2024"))
        XCTAssertEqual(sut.mimetypeText, "Type: image/jpeg")
        XCTAssertEqual(sut.idText, "ID: 1")
        XCTAssertEqual(sut.titleText, "Cat Details")
        XCTAssertEqual(sut.idLabelText, "Cat ID:")
    }
    func testUIModelNoTags() {
        // Given
        let entity = CatDetailEntity(id: "2", tags: [], createdAt: nil, url: "https://cataas.com/cat/2", mimetype: "image/png")
        // When
        let sut = CatDetailUIModel(from: entity)
        // Then
        XCTAssertEqual(sut.tagsText, "No tags")
        XCTAssertEqual(sut.tags, [])
        XCTAssertEqual(sut.createdAtText, "Unknown date")
        XCTAssertEqual(sut.mimetypeText, "Type: image/png")
        XCTAssertEqual(sut.idText, "ID: 2")
    }
    func testUIModelFallbackText() {
        // Given
        let entity = CatDetailEntity(id: "3", tags: [], createdAt: nil, url: "https://cataas.com/cat/3", mimetype: "image/gif")
        // When
        let sut = CatDetailUIModel(from: entity)
        // Then
        XCTAssertEqual(sut.fallbackText, "No information available")
    }
}

@MainActor
final class CatDetailViewModelTests: XCTestCase {
    func testFetchSuccess() async {
        // Given
        let useCase = MockUseCase(state: .data)
        let sut = CatDetailViewModel(id: "1", useCase: useCase)
        // When
        await sut.fetch()
        // Then
        XCTAssertNotNil(sut.uiModel)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.uiModel?.id, "1")
    }
    
    func testFetchError() async {
        // Given
        let useCase = MockUseCase(state: .error)
        let sut = CatDetailViewModel(id: "1", useCase: useCase)
        // When
        await sut.fetch()
        // Then
        XCTAssertNil(sut.uiModel)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.error)
    }
    
    func testFetchLoadingState() async {
        // Given
        let useCase = MockUseCase(state: .loading)
        let sut = CatDetailViewModel(id: "1", useCase: useCase)
        // When
        let expectation = XCTestExpectation(description: "Loading state")
        Task {
            await sut.fetch()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        // Then
        XCTAssertNil(sut.uiModel)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.error)
    }
}

enum ViewState {
    case loading, error, data
}

final class MockUseCase: FetchCatDetailUseCaseProtocol {
    let state: ViewState
    init(state: ViewState) { self.state = state }
    func execute(id: String) async -> Result<CatDetailEntity, Error> {
        switch state {
        case .loading:
            await Task.yield(); return .failure(MockError.loading)
        case .error:
            return .failure(MockError.some)
        case .data:
            return .success(CatDetailEntity(id: "1", tags: ["cute"], createdAt: "2024-06-20T12:00:00.000Z", url: "https://cataas.com/cat/1", mimetype: "image/jpeg"))
        }
    }
    enum MockError: Error { case loading, some }
}

