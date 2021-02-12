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
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case largeImageURL, downloads, likes, previewURL
        case user
    }
}
// MARK: - TypeEnum
enum TypeEnum: String, Codable {
    case photo = "photo"
}
