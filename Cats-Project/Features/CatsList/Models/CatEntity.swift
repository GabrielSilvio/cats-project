import Foundation

struct CatEntity: Decodable {
    let id: String
    let tags: [String]
    let mimetype: String
    let createdAt: String
} 