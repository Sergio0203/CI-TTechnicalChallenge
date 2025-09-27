//
//  PokemonModel.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

import UIKit

struct PokemonModel: Identifiable, Equatable {

    var id: Int?
    var name: String?
    var weight: Double?
    var image: String?
    var types: [PokeTypeName] = []

    init (id: Int, name: String, weight: Double, uiImage: String, types: [PokeTypes]) {
        self.id = id
        self.name = name.capitalized
        self.weight = weight
        self.image = uiImage
        types.forEach { typesArray in
            self.types.append(typesArray.type.name)
        }
    }
    
    init(pokemonResponse: PokeResponseDTO) {
        id = pokemonResponse.id
        name = pokemonResponse.name.capitalized
        weight = pokemonResponse.weight/10
        pokemonResponse.types.forEach { typesArray in
            self.types.append(typesArray.type.name)
        }
        image = pokemonResponse.sprites.front_default
    }

    init(pokeResult: PokeResults) {
        name = pokeResult.name.capitalized
    }
}
