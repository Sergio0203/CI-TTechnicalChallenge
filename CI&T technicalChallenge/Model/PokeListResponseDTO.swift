//
//  PokeListResponseDTO.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokeListResponseDTO: Decodable {
    var pokemon_species: [PokemonSpecie]
}

struct PokemonSpecie: Decodable {
    var name: String
}
