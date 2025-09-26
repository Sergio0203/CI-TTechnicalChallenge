//
//  PokeListResponseDTO.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//
import Foundation
struct PokeListResponseDTO: Decodable {
    var next: String?
    var previous: String?
    var results: [PokeResults]
}

extension PokeListResponseDTO {
    func getForwardOffset() -> Int? {
        guard let nextURLString = next else { return nil }
        guard let urlComponents = URLComponents(string: nextURLString) else { return nil }
        guard let queryItems = urlComponents.queryItems else { return nil }
        return queryItems.first(where: { $0.name == "offset" })?.value.flatMap(Int.init)
    }

    func getBackwardOffset() -> Int? {
        guard let previousURLString = previous else { return nil }
        guard let urlComponents = URLComponents(string: previousURLString) else { return nil }
        guard let queryItems = urlComponents.queryItems else { return nil }
        return queryItems.first(where: { $0.name == "offset" })?.value.flatMap(Int.init)
    }
}
struct PokeResults: Decodable {
    var name: String
}
