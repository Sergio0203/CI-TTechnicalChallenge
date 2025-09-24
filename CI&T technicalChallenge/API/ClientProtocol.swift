import Foundation

protocol ClientProtocol {
    func request<T: Decodable>(_ urlRequest: URLRequest) async throws -> T
}
