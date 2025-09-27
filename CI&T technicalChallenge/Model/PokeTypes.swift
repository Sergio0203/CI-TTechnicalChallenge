//
//  Untitled.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

import SwiftUI
enum PokeTypeName: String, Codable, Equatable {
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
    case unknow = "unknown"

    var color: Color {
        switch self {
        case .bug:
                .bug
        case .normal:
                .normal
        case .fire:
                .fire
        case .water:
                .water
        case .electric:
                .eletric
        case .grass:
                .grass
        case .ice:
                .ice
        case .fighting:
                .fighting
        case .poison:
                .poison
        case .ground:
                .ground
        case .flying:
                .flying
        case .dark:
                .dark
        case .dragon:
                .dragon
        case .fairy:
                .fairy
        case .rock:
                .rock
        case .stellar:
                .stellar
        case .psychic:
                .psychic
        case .steel:
                .steel
        case .ghost:
                .ghost
        case .unknow:
            Color.accentColor
        }

    }
}

struct PokeType: Codable {
    var name: PokeTypeName
}
