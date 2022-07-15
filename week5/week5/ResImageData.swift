import Foundation

struct KakaoImage: Codable {
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable {
    let thumbnailURL: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
    }
}

