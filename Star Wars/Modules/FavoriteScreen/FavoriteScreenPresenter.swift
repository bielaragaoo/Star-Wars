//
//  FavoriteScreenPresenter.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import Foundation

class FavoriteScreenPresenter: ViewToPresenterFavoriteScreenProtocol{
    var router: PresenterToRouterFavoriteScreenProtocol?
    var view: PresenterToViewFavoriteScreenProtocol?
    var interactor: PresenterToInteractorFavoriteScreenProtocol?
    
    func getFavorites() {
        interactor?.getFavorites()
    }
    
    func saveFavorites(starWarsCharacter: [StarWarsCharacterResult]) {
        interactor?.saveFavorites(starWarsCharacter: starWarsCharacter)
    }
}

extension FavoriteScreenPresenter: InteractorToPresenterFavoriteScreenProtocol {
    func onGetFavoriteList(favoriteList: [StarWarsCharacterResult]?) {
        view?.onGetFavoriteList(starWarsCharacter: favoriteList)
    }
    
    func onSaveCharacterListError() {
        view?.onSaveFavoriteListError()
    }
    
    
}
