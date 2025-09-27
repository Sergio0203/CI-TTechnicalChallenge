//
//  PokeServiceProtocol.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 26/09/25.
//

protocol PokeServiceProtocol {
    func getPokemons(offset: Int) async throws -> PokeListResponseDTO
    func getPokemon(name: String) async throws -> PokeResponseDTO
}
