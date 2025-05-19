import Foundation

final class CatsAPIMockService: CatsAPIServiceProtocol {
    func fetchCats(skip: Int, limit: Int) async throws -> [CatSummary] {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return MockCatData.catSummaries
    }
}

struct MockCatData {
    static let catSummaries: [CatSummary] = [
        CatSummary(
            id: "0F0IKAPOdWiE755P",
            tags: ["meet", "cute"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2024-06-18T09:46:45.702Z")!
        ),
        CatSummary(
            id: "0GC9MRUAqxhBzPyA",
            tags: ["cute"],
            mimetype: "image/png",
            createdAt: ISO8601DateFormatter().date(from: "2024-09-15T15:45:25.375Z")!
        ),
        CatSummary(
            id: "0mstmOIucwiN80jb",
            tags: ["cute", "black"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2023-10-25T00:04:03.771Z")!
        ),
        CatSummary(
            id: "0RU7ZkgzyvWv8UJG",
            tags: ["tuxedo", "computer", "sleepy", "cute", "sleeping"],
            mimetype: "image/png",
            createdAt: ISO8601DateFormatter().date(from: "2024-04-20T22:52:58.132Z")!
        ),
        CatSummary(
            id: "0ztFbDrgDV2K7yJ1",
            tags: ["cute", "orange", "funny", "lasagna", "garfield"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2024-08-23T20:15:26.393Z")!
        ),
        CatSummary(
            id: "1bJraW0IwSPm3MVd",
            tags: ["cute", "fluffy"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2022-04-27T01:49:50.792Z")!
        ),
        CatSummary(
            id: "1CF7xZmlX0t8QpgP",
            tags: ["ange", "cute"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2016-11-22T05:38:06.656Z")!
        ),
        CatSummary(
            id: "1DrcyohjhwcNaRIz",
            tags: ["cute", "orange", "sleepy", "tired", "outside", "grass"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2024-02-29T00:49:57.420Z")!
        ),
        CatSummary(
            id: "1KeQpy7eHqi0SFmc",
            tags: ["orange", "cute", "lying", "bed", "blanket"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2024-10-08T23:54:00.959Z")!
        ),
        CatSummary(
            id: "1N2AH31jiY6N9TYc",
            tags: ["cute", "mlem"],
            mimetype: "image/jpeg",
            createdAt: ISO8601DateFormatter().date(from: "2024-02-08T07:59:29.085Z")!
        )
    ]
    
    static let catModels: [CatRowUIModel] = catSummaries.map { CatRowUIModel(from: $0) }
} 