//
//  CharacterListResponse.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

class CharacterListResponse: ResponseHandler{
    var starWarsCharacters: StarWarsCharacter?
    
    override func parseModel() throws {
        if success() {
            guard let data = data else {return}
            starWarsCharacters = try JSONDecoder().decode(StarWarsCharacter.self, from: data)
        }
    }
    
}
