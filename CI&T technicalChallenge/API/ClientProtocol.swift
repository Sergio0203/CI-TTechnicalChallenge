import Foundation

protocol ClientProtocol {
    func request<T: Decodable>(_ endPoint: APIEndpoint) async throws -> T
}
