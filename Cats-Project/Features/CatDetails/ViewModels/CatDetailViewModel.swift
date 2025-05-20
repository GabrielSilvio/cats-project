import Foundation
import SwiftUI

@MainActor
final class CatDetailViewModel: ObservableObject {
    private let summary: CatSummary
    
    let id: String
    let imageURL: URL
    let mimetype: String
    let tags: [String]
    let createdAtFormatted: String
    
    init(summary: CatSummary) {
        self.summary = summary
        self.id = summary.id
        let ext = summary.mimetype.components(separatedBy: "/").last ?? "jpg"
        self.imageURL = URL(string: "https://cataas.com/cat/\(summary.id).\(ext)")!
        self.mimetype = summary.mimetype
        self.tags = summary.tags.map { $0.capitalized }
        self.createdAtFormatted = DateFormatterHelper.formatISO8601String(summary.createdAt, dateStyle: .long, timeStyle: .short, locale: Locale(identifier: "en_US"))
    }
}
