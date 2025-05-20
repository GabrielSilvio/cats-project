import Foundation

struct CatDetailAnimatedModel: Identifiable, Hashable {
    let id: String
    let imageURL: URL
    let mainTag: String
    let createdAtText: String
    let tagsText: String
    let fallbackText: String

    init(from summary: CatSummary) {
        id = summary.id
        imageURL = URL(string: "https://cataas.com/cat/\(summary.id)")!
        mainTag = summary.tags.first?.capitalized ?? "Cat"
        createdAtText = DateFormatterHelper.formatISO8601String(summary.createdAt, dateStyle: .full, timeStyle: .short)
        tagsText = summary.tags.isEmpty ? "No tags" : summary.tags.map { $0.capitalized }.joined(separator: ", ")
        fallbackText = "No information available"
    }
} 