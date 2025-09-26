//
//  PokemonModel.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokemonModel: Identifiable{
  
    var id: Int
    var name: String
    var weight: Int
    var imageUrl: String
    var types: [PokeTypes]

    init (id: Int, name: String, weight: Int, imageUrl: String, types: [PokeTypes]) {
        self.id = id
        self.name = name
        self.weight = weight
        self.imageUrl = imageUrl
        self.types = types
    }

    init(pokemonResponse: PokeResponseDTO) {
        id = pokemonResponse.id
        name = pokemonResponse.name
        weight = pokemonResponse.weight
        imageUrl = pokemonResponse.sprites.front_default
        types = pokemonResponse.types
    }
}
