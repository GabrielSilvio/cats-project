import Foundation

protocol CatsRepositoryProtocol {
    func getCats(skip: Int, limit: Int) async -> Result<Data, Error>
}

final class CatsRepository: CatsRepositoryProtocol {
    private let baseURL = "https://cataas.com"
    func getCats(skip: Int, limit: Int) async -> Result<Data, Error> {
        guard let url = URL(string: "\(baseURL)/api/cats?skip=\(skip)&limit=\(limit)") else {
            return .failure(URLError(.badURL))
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
                return .failure(URLError(.badServerResponse))
            }
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}

final class CatsRepositoryMock: CatsRepositoryProtocol {
    func getCats(skip: Int, limit: Int) async -> Result<Data, Error> {
        let json = """
        [
        {"id":"04eEQhDfAL8l5nt3","tags":["two","double","black"],"mimetype":"image/jpeg","createdAt":"2022-07-18T11:28:29.596Z"},
        {"id":"05Xd4JtN14983pns","tags":["Cute"],"mimetype":"image/jpeg","createdAt":"2024-05-27T17:55:08.552Z"},
        {"id":"09wFxpacQzvf9jfM","tags":["Maskcat"],"mimetype":"image/jpeg","createdAt":"2021-08-17T06:26:37.959Z"},
        {"id":"0B2g7aTANObiqPJJ","tags":["creation"],"mimetype":"image/jpeg","createdAt":"2016-11-25T03:46:12.562Z"},
        {"id":"0BTTVEVWXNyOgXYd","tags":[],"mimetype":"image/jpeg","createdAt":"2020-10-19T18:52:55.627Z"},
        {"id":"0C2bQ39x8kuhx31p","tags":["sara","looking"],"mimetype":"image/jpeg","createdAt":"2021-11-11T10:16:22.061Z"},
        {"id":"0DVs2d6bIVIt3ehk","tags":["birthday","cake","happy"],"mimetype":"image/gif","createdAt":"2024-02-06T20:07:13.052Z"},
        {"id":"0EsIYDG0at0TPpPD","tags":["fat"],"mimetype":"image/jpeg","createdAt":"2022-03-26T23:13:25.966Z"},
        {"id":"0F0IKAPOdWiE755P","tags":["meet","cute"],"mimetype":"image/jpeg","createdAt":"2024-06-18T09:46:45.702Z"},
        {"id":"0GC9MRUAqxhBzPyA","tags":["cute"],"mimetype":"image/png","createdAt":"2024-09-15T15:45:25.375Z"}
        ]
        """
        return .success(Data(json.utf8))
    }
}
