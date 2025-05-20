import Foundation

struct CatDetailUIModel {
    let id: String
    let imageURL: URL?
    let tagsText: String
    let createdAtText: String
    let mimetypeText: String
    let idText: String
    let fallbackText: String

    init(from entity: CatDetailEntity) {
        id = entity.id
        imageURL = URL(string: entity.url)
        tagsText = entity.tags.isEmpty ? "Sem tags" : entity.tags.joined(separator: ", ")
        createdAtText = entity.createdAt != nil ? DateFormatterHelper.formatISO8601String(entity.createdAt!, dateStyle: .full, timeStyle: .short, locale: Locale(identifier: "en_US_POSIX")) : "Data desconhecida"
        mimetypeText = "Tipo: \(entity.mimetype)"
        idText = "ID: \(entity.id)"
        fallbackText = "Informação não disponível"
    }
}
