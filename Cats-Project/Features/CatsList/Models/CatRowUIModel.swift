import Foundation

struct CatRowUIModel: Identifiable, Hashable {
    let id: String
    let thumbnailURL: URL
    let mainTag: String
    let createdAtText: String
    let tagsText: String
    let fallbackText: String
    let summary: CatSummary

    init(from summary: CatSummary) {
        id = summary.id
        thumbnailURL = URL(string: "https://cataas.com/cat/\(summary.id)")!
        mainTag = summary.tags.first?.capitalized ?? "Cat"
        createdAtText = DateFormatterHelper.formatISO8601String(summary.createdAt)
        tagsText = summary.tags.isEmpty ? "No tags" : summary.tags.map { $0.capitalized }.joined(separator: ", ")
        fallbackText = "No information available"
        self.summary = summary
    }
}
