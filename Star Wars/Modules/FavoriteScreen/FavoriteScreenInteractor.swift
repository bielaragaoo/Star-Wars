//
//  FavoriteScreenInteractor.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import Foundation
class FavoriteScreenInteractor: PresenterToInteractorFavoriteScreenProtocol {
    var delegate: InteractorToPresenterFavoriteScreenProtocol?
    func getFavorites() {
        do {
         let characterList = try LocalDatabaseManager.sharedInstance.getFavorites() as [StarWarsCharacterResult]
            delegate?.onGetFavoriteList(favoriteList: characterList)
        } catch {
            delegate?.onGetFavoriteList(favoriteList: [])
        }
    }
    
    func saveFavorites(starWarsCharacter: [StarWarsCharacterResult]) {
        do{
           try LocalDatabaseManager.sharedInstance.saveFavorite(starWarsCharacterResult: starWarsCharacter)
            self.getFavorites()
        } catch {
            delegate?.onSaveCharacterListError()
        }
    }
    
    
    
}
