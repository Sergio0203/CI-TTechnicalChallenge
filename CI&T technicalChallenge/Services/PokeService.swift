//
//  PokeService.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokeService: PokeServiceProtocol {
    var client: ClientProtocol
    let pokeEndPoint = PokeAPIEndpoint.self
    init (client: ClientProtocol = URLSessionClient()) {
        self.client = client
    }
    
    func getPokemons(offset: Int) async throws -> PokeListResponseDTO {
        try await client.request(pokeEndPoint.getPokemons(offset: offset))
    }
    
    func getPokemon(name: String) async throws -> PokeResponseDTO {
        try await client.request(pokeEndPoint.getPokemonFromName(name: name))
    }
}
