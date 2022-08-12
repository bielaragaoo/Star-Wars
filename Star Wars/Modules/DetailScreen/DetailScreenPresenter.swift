//
//  DetailScreenPresenter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenPresenter: ViewToPresenterDetailScreenProtocol {
    func getSpecie(speciePath: String) {
        interactor?.getSpecie(speciePath: speciePath)
    }
    
    func getHomeWorld(homeWorldPath: String) {
        interactor?.getHomeWorld(homeWorldPath: homeWorldPath)
    }
    
    var router: PresenterToRouterDetailScreenProtocol?
    
    var view: PresenterToViewDetailScreenProtocol?
    var interactor: PresenterToInteractorDetailScreenProtocol?
    
    func getFavorite() {
        interactor?.getFavorite()
    }
    func saveFavorite(starWarsCharacterResult: [StarWarsCharacterResult]) {
        interactor?.saveFavorite(starWarsCharacterResult: starWarsCharacterResult)
    }
}

extension DetailScreenPresenter: InteractorToPresenterDetailScreenProtocol{
    func onGetHomeWorldSuccess(homeWorld: HomeWorld) {
        view?.onGetHomeWorldSucess(homeWorld: homeWorld)
    }
    
    func onGetSpecieSuccess(specie: Specie) {
        view?.onGetSpecieSuccess(specie: specie)
    }
    
    func onGetSpecieError() {
        view?.onGetSpecieError()
    }
    
    func onGetHomeWorldError() {
        view?.onGetHomeWorldError()
    }
    
    func onGetFavorites(starWarsCharacterResult: [StarWarsCharacterResult]?) {
        view?.onGetFavorite(starWarsCharacterResult: starWarsCharacterResult)
    }
}
