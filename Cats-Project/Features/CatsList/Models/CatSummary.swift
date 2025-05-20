import Foundation

struct CatSummary: Decodable, Identifiable, Hashable {
    let id: String
    let tags: [String]
    let mimetype: String
    let createdAt: String 
} 
