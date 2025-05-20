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
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: summary.createdAt) {
            createdAtText = formatter.string(from: date)
        } else {
            createdAtText = "Invalid date"
        }
        self.summary = summary
    }
}
