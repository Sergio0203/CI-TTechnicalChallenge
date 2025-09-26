//
//  APIEnum.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 24/09/25.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum PokeAPIEndpoint: APIEndpointProtocol {

    case getPokemonFromName(name: String)
    case getPokemons(offset: Int)

    var baseUrl: URL {
        URL(string: "https://pokeapi.co/api/v2/")!
    }

    var path: String {
        switch self {
        case .getPokemons:
            return "pokemon"
        case .getPokemonFromName(name: let name):
            return "pokemon/\(name)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPokemonFromName, .getPokemons:
            return .get
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getPokemonFromName, .getPokemons:
            return ["Content-Type": "apllication/json", "Accept": "apllication/json"]
        }
    }

    var parameters: [String : Any] {
        [:]
    }

    var query: [String : Int] {
        switch self {
        case .getPokemons(offset: let offset):
            return ["limit": 10, "offset": offset]
        case .getPokemonFromName:
            return [:]
        }
    }
}
