//
//  FavoriteScreenContract.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import UIKit

protocol PresenterToViewFavoriteScreenProtocol {
    func reloadData()
    func saveFavoriteListError()
}

protocol ViewToPresenterFavoriteScreenProtocol {
    func getFavorites()
    func saveFavorites(starWarsCharacter: [StarWarsCharacterResult])
    func favoriteTableViewCount() -> Int
    func favoriteCharactersOnView() -> [StarWarsCharacterResult]?
    func onPressToFavorite(index: Int)
}

protocol PresenterToInteractorFavoriteScreenProtocol {
    
    func getFavorites()
    func saveFavorites(starWarsCharacter: [StarWarsCharacterResult])
}

protocol PresenterToRouterFavoriteScreenProtocol {
    static func createModule() -> UIViewController
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, starWarsCharacterResult: StarWarsCharacterResult)
}

protocol InteractorToPresenterFavoriteScreenProtocol {
    func onGetFavoriteList(favoriteList: [StarWarsCharacterResult]?)
    func onSaveCharacterListError()
}
