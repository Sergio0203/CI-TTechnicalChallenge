//
//  URLSessionClient.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//
import Foundation
struct URLSessionClient: ClientProtocol {

    func request<T>(_ endPoint: APIEndpointProtocol) async throws -> T where T : Decodable {

        var url = endPoint.baseUrl
        url.append(component: endPoint.path)
        endPoint.query.forEach { key, value in
            url.append(queryItems: [.init(name: key, value: String(value))])
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        endPoint.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
         
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        return try handleHTTPResponse(httpResponse, data: data)
    }
    
    private func handleHTTPResponse<T: Decodable>(_ response: HTTPURLResponse, data: Data) throws -> T {
        switch response.statusCode {
        case 200...299:
            return try decodeObject(data)
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknown
        }
    }
    
    private func decodeObject<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedObject: T = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw NetworkError.decodingError
        }
    }
}
