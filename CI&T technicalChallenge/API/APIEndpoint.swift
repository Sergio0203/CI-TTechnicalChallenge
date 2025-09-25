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
    case getPokemonsFromGeneration(generation: Int)
    case getPokemonFromID(id: Int)
    case getPokemonFromName(name: String)
    
    var baseUrl: String {
      return "https://pokeapi.co/api/v2/"
    }
    
    var path: String {
        switch self {
            case .getPokemonsFromGeneration(generation: let generation):
            return baseUrl + "generation/\(generation)/"
        case .getPokemonFromID(id: let id):
            return baseUrl + "pokemon/\(id)"
        case .getPokemonFromName(name: let name):
            return baseUrl + "pokemon/\(name)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPokemonFromName, .getPokemonFromID, .getPokemonsFromGeneration:
            return .get
        }
    }
    
    var header: [String: String] {
        switch self {
        case .getPokemonFromName, .getPokemonFromID, .getPokemonsFromGeneration:
            return ["Content-Type": "apllication/json"]
        }
    }
}
