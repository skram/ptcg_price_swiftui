//
//  Pokemon.swift
//  WHOPadex
//
//  Created by Mark Peterson on 12/14/24.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable, Identifiable, Hashable {
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let id, name: String
    let supertype: Supertype
    let subtypes: [Subtype]
    let hp: String?
    let types: [EnergyType]?
    let evolvesTo: [String]?
    let attacks: [Attack]?
    let weaknesses: [Resistance]?
    let retreatCost: [EnergyType]?
    let convertedRetreatCost: Int?
    let number, artist: String
    let rarity: Rarity
    let flavorText: String?
    let nationalPokedexNumbers: [Int]?
    let legalities: Legalities
    let images: Images?
    let evolvesFrom: String?
    let resistances: [Resistance]?
    let rules: [String]?
    let abilities: [Ability]?
    let ancientTrait: AncientTrait?
    let level: String?
    
    var hasEvolutions : Bool {
        return !(evolvesTo?.isEmpty ?? true)
    }
    
    var generatedSearchURL:URL? {
        return URL(string: "https://www.tcgplayer.com/search/pokemon/product?Language=English&productLineName=pokemon&q=\(self.name)+\(self.number)&view=grid")
    }
}

// MARK: - Ability
struct Ability: Codable {
    let name, text: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case ability = "Ability"
}

// MARK: - AncientTrait
struct AncientTrait: Codable {
    let name, text: String
}

// MARK: - Attack
struct Attack: Codable {
    let name: String
    let cost: [EnergyType]
    let convertedEnergyCost: Int
    let damage, text: String
}

enum EnergyType: String, Codable {
    case colorless = "Colorless"
    case darkness = "Darkness"
    case dragon = "Dragon"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case grass = "Grass"
    case lightning = "Lightning"
    case metal = "Metal"
    case psychic = "Psychic"
    case water = "Water"
}

// MARK: - Images
struct Images: Codable {
    let small, large: String
}

// MARK: - Legalities
struct Legalities: Codable {
    let unlimited, expanded: Expanded
}

enum Expanded: String, Codable {
    case legal = "Legal"
}

enum Rarity: String, Codable {
    case promo = "Promo"
}

// MARK: - Resistance
struct Resistance: Codable {
    let type: EnergyType
    let value: String
}

enum Subtype: String, Codable {
    case basic = "Basic"
    case ex = "EX"
    case item = "Item"
    case mega = "MEGA"
    case pokémonTool = "Pokémon Tool"
    case stadium = "Stadium"
    case stage1 = "Stage 1"
    case stage2 = "Stage 2"
    case subtypeBREAK = "BREAK"
    case supporter = "Supporter"
}

enum Supertype: String, Codable {
    case pokémon = "Pokémon"
    case trainer = "Trainer"
}
