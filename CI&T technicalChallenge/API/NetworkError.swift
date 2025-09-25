enum NetworkError: Error {
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case decodingError
    case invalidURL
    case unknown
}
