//
//  FavoriteScreenContract.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import UIKit

protocol PresenterToViewFavoriteScreenProtocol {
    func onGetFavoriteList(starWarsCharacter: [StarWarsCharacterResult]?)
    func onSaveFavoriteListError()
}

protocol ViewToPresenterFavoriteScreenProtocol {
    var view: PresenterToViewFavoriteScreenProtocol? { get set }
    var interactor: PresenterToInteractorFavoriteScreenProtocol? { get set }
    var router: PresenterToRouterFavoriteScreenProtocol? { get set }
    
    func getFavorites()
    func saveFavorites(starWarsCharacter: [StarWarsCharacterResult])
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
