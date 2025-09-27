//
//  PokeServiceMock.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 26/09/25.
//


import Foundation
@testable import CI_T_technicalChallenge

enum MockError: LocalizedError {
    case networkError
    case cancelled

    var errorDescription: String?  {
        switch self {
        case .networkError:
            return "Erro de rede"
        case .cancelled:
            return "cancelled"
        }
    }
}

final class MockPokeService: PokeServiceProtocol {

    var pokemonListResult: Result<PokeListResponseDTO, Error>!
    var pokemonDetailResult: Result<PokeResponseDTO, Error>!

    func getPokemons(offset: Int) async throws -> PokeListResponseDTO {
        switch pokemonListResult {
        case .success(let dto):
            return dto
        case .failure(let error):
            throw error
        case .none:
            fatalError("Resultado não configurado para getPokemons")
        }
    }

    func getPokemon(name: String) async throws -> PokeResponseDTO {
        switch pokemonDetailResult {
        case .success(let dto):
            return dto
        case .failure(let error):
            throw error
        case .none:
            fatalError("Resultado não configurado para getPokemon")
        }
    }
}
