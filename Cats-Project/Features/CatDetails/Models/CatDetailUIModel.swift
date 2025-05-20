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
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: summary.createdAt) {
            createdAtText = formatter.string(from: date)
        } else {
            createdAtText = "Invalid date"
        }
    }
}
