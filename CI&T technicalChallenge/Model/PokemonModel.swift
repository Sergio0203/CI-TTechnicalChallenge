//
//  PokemonModel.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

import UIKit

struct PokemonModel: Identifiable{

    var id: Int
    var name: String
    var weight: Int
    var image: UIImage?
    var types: [PokeTypeName] = []

    init (id: Int, name: String, weight: Int, uiImage: UIImage, types: [PokeTypes]) {
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
        weight = pokemonResponse.weight
        pokemonResponse.types.forEach { typesArray in
            self.types.append(typesArray.type.name)
        }
        image = getUIImagefromUrl(imageUrl: pokemonResponse.sprites.front_default)
    }

    private func getUIImagefromUrl(imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else {
            return UIImage()
        }
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            return image
        } catch {
            return nil
        }
    }
}
