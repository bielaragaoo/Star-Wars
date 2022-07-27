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

extension HomeScreenPresenter: HomeScreenCharacterListResponseProtocol {
    func responseGetCharacterListError(error: Error?) {
        view?.onGetCharacterListError(error!)
    }
    
    
    func responseGetCharacterListSuccess(data: StarWarsCharacter?) {
        if let data = data {
            view?.onGetCharacterListSucess(data)
        } else {
            view?.onGetCharacterListError(data as! Error)
        }
    }
}

