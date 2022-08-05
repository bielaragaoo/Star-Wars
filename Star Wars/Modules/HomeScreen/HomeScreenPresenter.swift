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
    
    func viewDidLoad(path: String?) {
        interactor?.getCharacters(path: path)
    }
}

extension HomeScreenPresenter: InteractorToPresenterHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        
        view?.onGetCharacterListSucess(starWarsCharacter)
        
    }
    
    func onGetCharacterListError() {
        view?.onGetCharacterListError()
    }
    
}

