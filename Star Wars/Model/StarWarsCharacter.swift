//
//  StarWarsCharacter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

struct StarWarsCharacter: Codable {
    
    let results: [StarWarsCharacterResult]
}

struct StarWarsCharacterResult: Codable {
    
    let birthYear: String?
    let eyeColor: String?
    let gender: String?
    let name: String?
    let homeWorld: String?
    let species: [String?]
    let height: String?
    let mass: String?
    let skinColor: String?
    
    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case gender
        case name
        case homeWorld = "homeworld"
        case species
        case height
        case mass
        case skinColor = "skin_color"
    }
}


