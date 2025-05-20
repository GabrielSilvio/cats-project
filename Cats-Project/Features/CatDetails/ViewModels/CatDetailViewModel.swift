import Foundation
import SwiftUI

@MainActor
final class CatDetailViewModel: ObservableObject {
    private let summary: CatSummary
    
    let id: String
    let imageURL: URL?
    let mimetype: String
    let tags: [String]
    let createdAtFormatted: String
    
    init(summary: CatSummary) {
        self.summary = summary
        self.id = summary.id
        self.imageURL = URL(string: "https://cataas.com/cat/\(summary.id)") 
        
        self.mimetype = summary.mimetype
        self.tags = summary.tags.map { $0.capitalized }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: summary.createdAt) {
            self.createdAtFormatted = formatter.string(from: date)
        } else {
            self.createdAtFormatted = "Invalid date"
        }
    }
}
