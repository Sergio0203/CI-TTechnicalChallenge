import Foundation

protocol ClientProtocol {
    func request<T: Decodable>(_ endPoint: APIEndpointProtocol) async throws -> T
}
