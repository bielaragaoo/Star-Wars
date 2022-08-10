//
//  LocalDatabaseManager.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 08/08/22.
//

import Foundation
class LocalDatabaseManager {
    static let sharedInstance = LocalDatabaseManager()
    
    func saveFavorite(starWarsCharacterResult: [StarWarsCharacterResult]) throws {
        let charactersList = try JSONEncoder().encode(starWarsCharacterResult)
        UserDefaults.standard.set(charactersList, forKey: "StarWarsCharacterResult")
    }
    
    func getFavorites() throws -> [StarWarsCharacterResult]{
        guard let charactersList = UserDefaults.standard.data(forKey: "StarWarsCharacterResult") else {return []
        }
        return try JSONDecoder().decode([StarWarsCharacterResult].self, from: charactersList)
    }
}
