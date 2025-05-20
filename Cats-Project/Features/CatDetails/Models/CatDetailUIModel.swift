import Foundation

struct CatDetailUIModel {
    let id: String
    let imageURL: URL?
    let tagsText: String
    let createdAtText: String

    init(from summary: CatSummary) {
        id = summary.id
        let ext = summary.mimetype.components(separatedBy: "/").last ?? "jpg"
        imageURL = URL(string: "https://cataas.com/cat/\(summary.id).\(ext)")
        tagsText = summary.tags.joined(separator: ", ")
        createdAtText = DateFormatterHelper.formatISO8601String(summary.createdAt, dateStyle: .full, timeStyle: .short, locale: Locale(identifier: "en_US_POSIX"))
    }
}
