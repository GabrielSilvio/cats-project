import Foundation

struct CatDetailEntity: Decodable {
    let id: String
    let tags: [String]
    let createdAt: String?
    let url: String
    let mimetype: String
    
    enum CodingKeys: String, CodingKey {
        case id, tags, url, mimetype
        case createdAt = "created_at"
    }
} 
