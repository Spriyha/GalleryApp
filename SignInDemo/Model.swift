import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let urls: PhotoUrls
    
    struct PhotoUrls: Codable {
        let regular: String
    }
}
