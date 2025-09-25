import Foundation
enum NetworkError: LocalizedError {
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case decodingError
    case invalidURL
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Server Error"
        case .decodingError:
            return "Decoding Error"
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        }
    }
}
