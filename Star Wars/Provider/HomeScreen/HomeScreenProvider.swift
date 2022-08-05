//
//  HomeScreenProvider.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

class HomeScreenProvider {
    private let characterListRequest = CharacterListRequest()
    
}

protocol HomeScreenProviderProtocol {
    func getCharacterList (path: String?, sucessCallback: @escaping(StarWarsCharacter?) -> Void, failureCallback: @escaping (Error?) -> Void)
}

extension HomeScreenProvider: HomeScreenProviderProtocol {
    func getCharacterList(path: String?, sucessCallback: @escaping (StarWarsCharacter?) -> Void, failureCallback: @escaping (Error?) -> Void) {
        NetworkManager.sharedInstance.request(path: path, request: characterListRequest) { (response: CharacterListResponse) in
            if let error = response.error {
                failureCallback(error)
                return
            }
            
            let data = response.starWarsCharacters
            sucessCallback(data)
        }
    }
}
