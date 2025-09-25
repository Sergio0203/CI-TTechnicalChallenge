//
//  PokeResponseDTO.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokeResponseDTO: Decodable {
    var id: Int
    var name: String
    var sprites: Sprites
    var types: [PokeTypes]
    var weight: Int
    
}

struct PokeTypes: Codable {
    var type: PokeType
}
struct Sprites: Codable {
    var front_default: String
}
