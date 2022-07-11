//
//  HomeScreenPresenter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

class HomeScreenPresenter: ViewToPresenterHomeScreenProtocol {
    var view: PresenterToViewHomeScreenProtocol?
    
    var interactor: PresenterToInteractorHomeScreenProtocol?
    
    var router: PresenterToRouterHomeScreenProtocol?
    
    func viewDidLoad() {
        interactor?.getCharacters()
    }
}

extension HomeScreenPresenter: InteractorToPresenterHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        view?.onGetCharacterListSucess(starWarsCharacter)
    }
    
    func onGetCharacterListError(_ starWarsCharacter: StarWarsCharacter) {
        view?.onGetCharacterListError(starWarsCharacter)
    }
    
    
}
