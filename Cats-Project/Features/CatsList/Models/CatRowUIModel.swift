import Foundation

struct CatRowUIModel: Identifiable, Hashable {
    let id: String
    let thumbnailURL: URL
    let mainTag: String
    let createdAtText: String
    let summary: CatSummary

    init(from summary: CatSummary) {
        id = summary.id
        thumbnailURL = URL(string: "https://cataas.com/cat/\(summary.id)")!
        mainTag = summary.tags.first?.capitalized ?? "Cat"
        createdAtText = DateFormatterHelper.formatISO8601String(summary.createdAt)
        self.summary = summary
    }
}
