//
//  PokeService.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

struct PokeService {
    var client: ClientProtocol
    
    init (client: ClientProtocol = URLSessionClient()) {
        self.client = client
    }
    
    func getPokeList(from generation: Int) async throws ->  PokeListResponseDTO {
        try await client.request(.getPokemonsFromGeneration(generation: generation))
    }
    
    func getPokemon(id: Int) async throws -> PokeResponseDTO {
        try await client.request(.getPokemonFromID(id: id))
    }
    
    func getPokemon(name: String) async throws -> PokeResponseDTO {
        try await client.request(.getPokemonFromName(name: name))
    }
    
}
