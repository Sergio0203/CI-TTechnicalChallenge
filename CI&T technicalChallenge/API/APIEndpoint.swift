//
//  APIEnum.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 24/09/25.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum APIEndpoint{
    case getPokemons(generation: Int)
    case getPokemon(id: String)
    
    static var baseUrl = "https://pokeapi.co/api/v2/"
    
    var path: String {
        switch self {
            case .getPokemons(generation: let generation):
            return "pokemon?limit=100&offset=\(generation * 100)"
        case .getPokemon(id: let id):
            return "pokemon/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPokemons, .getPokemon:
            return .get
        }
    }
    
    var header: [String: String] {
        switch self {
            case .getPokemons, .getPokemon:
            return ["Content-Type": "apllication/json"]
        }
    }
}
