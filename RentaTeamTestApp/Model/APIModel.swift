import Foundation

// MARK: - PhotoData
struct PhotoData: Codable {
    let hits: [Photo]
}

// MARK: - Photo
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
