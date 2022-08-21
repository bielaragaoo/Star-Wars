//
//  FavoriteScreenPresenter.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import Foundation

class FavoriteScreenPresenter: ViewToPresenterFavoriteScreenProtocol{
    private var router: PresenterToRouterFavoriteScreenProtocol
    private var view: PresenterToViewFavoriteScreenProtocol
    private var interactor: PresenterToInteractorFavoriteScreenProtocol
    
    private var favoriteCharacters: [StarWarsCharacterResult]?
    
    init(router: PresenterToRouterFavoriteScreenProtocol, view: PresenterToViewFavoriteScreenProtocol, interactor: PresenterToInteractorFavoriteScreenProtocol){
        self.router = router
        self.view = view
        self.interactor = interactor
    }
    
    func getFavorites() {
        interactor.getFavorites()
    }
    
    func saveFavorites(starWarsCharacter: [StarWarsCharacterResult]) {
        interactor.saveFavorites(starWarsCharacter: starWarsCharacter)
    }
    
    func favoriteTableViewCount() -> Int {
        return favoriteCharacters?.count ?? 0
    }
    
    func favoriteCharactersOnView() -> [StarWarsCharacterResult]? {
        return favoriteCharacters
    }
    
    func onPressToFavorite(index: Int) {
        favoriteCharacters?.remove(at: index)
        interactor.saveFavorites(starWarsCharacter:favoriteCharacters ??  [] )
        view.reloadData()
    }
    
}

extension FavoriteScreenPresenter: InteractorToPresenterFavoriteScreenProtocol {
    func onGetFavoriteList(favoriteList: [StarWarsCharacterResult]?) {
        favoriteCharacters = favoriteList
    }
    
    func onSaveCharacterListError() {
        view.saveFavoriteListError()
    }
}
