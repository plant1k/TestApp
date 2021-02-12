import Foundation

// MARK: - Welcome
struct PhotoData: Codable {
    let hits: [Photo]
}

// MARK: - Hit
struct Photo: Codable {
    let largeImageURL: String
    let downloads, likes: Int
    let user: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case largeImageURL, downloads, likes, previewURL
        case user
    }
}

enum TypeEnum: String, Codable {
    case photo = "photo"
}
