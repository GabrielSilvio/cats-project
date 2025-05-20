import Foundation

struct CatDetailUIModel {
    let id: String
    let imageURL: URL?
    let tags: [String]
    let tagsText: String
    let createdAtText: String
    let mimetypeText: String
    let idText: String
    let fallbackText: String
    let titleText: String
    let idLabelText: String

    init(from entity: CatDetailEntity) {
        id = entity.id
        imageURL = URL(string: entity.url)
        tags = entity.tags
        tagsText = entity.tags.isEmpty ? "No tags" : entity.tags.joined(separator: ", ")
        createdAtText = entity.createdAt != nil ? DateFormatterHelper.formatISO8601String(entity.createdAt ?? "", dateStyle: .full, timeStyle: .short, locale: Locale(identifier: "en_US_POSIX")) : "Unknown date"
        mimetypeText = "Type: \(entity.mimetype)"
        idText = "ID: \(entity.id)"
        fallbackText = "No information available"
        titleText = "Cat Details"
        idLabelText = "Cat ID:"
    }
}
