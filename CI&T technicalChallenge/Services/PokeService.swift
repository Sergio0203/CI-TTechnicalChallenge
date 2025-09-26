//
//  PokeService.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokeService {
    var client: ClientProtocol
    let pokeEndPoint = PokeAPIEndpoint.self
    init (client: ClientProtocol = URLSessionClient()) {
        self.client = client
    }
    
    func getPokemons() async throws -> PokeListResponseDTO {
        try await client.request(pokeEndPoint.getPokemon)
    }
    
    func getPokemon(name: String) async throws -> PokeResponseDTO {
        try await client.request(pokeEndPoint.getPokemonFromName(name: name))
    }
    
}
