//
//  PokeListResponseDTO.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokeListResponseDTO: Decodable {
    var results: [PokeResults]
}

struct PokeResults: Decodable {
    var name: String
}
