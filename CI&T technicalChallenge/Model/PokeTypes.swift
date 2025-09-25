//
//  Untitled.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

enum PokeTypeName: String, Codable{
    case bug = "bug"
    case normal = "normal"
    case fire = "fire"
    case water = "water"
    case electric = "electric"
    case grass = "grass"
    case ice = "ice"
    case fighting = "fighting"
    case poison = "poison"
    case ground = "ground"
    case flying = "flying"
    case dark = "dark"
    case dragon = "dragon"
    case fairy = "fairy"
    case rock = "rock"
    case stellar = "stellar"
    case psychic = "psychic"
    case steel = "steel"
    case ghost = "ghost"
}

struct PokeType: Codable {
    var name: PokeTypeName
}
