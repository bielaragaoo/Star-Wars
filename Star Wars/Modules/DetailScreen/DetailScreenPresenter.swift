//
//  DetailScreenPresenter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenPresenter: ViewToPresenterDetailScreenProtocol {
    var router: PresenterToRouterDetailScreenProtocol?
    
    var view: PresenterToViewDetailScreenProtocol?
    var interactor: PresenterToInteractorDetailScreenProtocol?
    
    func getCustomDetail(speciePath: String, homeWorldPath: String) {
        interactor?.getCustomDetail(speciePath: speciePath, homeWorldPath: homeWorldPath)
    }
    func getFavorite() {
        interactor?.getFavorite()
    }
    func saveFavorite(starWarsCharacterResult: [StarWarsCharacterResult]) {
        interactor?.saveFavorite(starWarsCharacterResult: starWarsCharacterResult)
    }
}

extension DetailScreenPresenter: InteractorToPresenterDetailScreenProtocol{
    func onGetFavorites(starWarsCharacterResult: [StarWarsCharacterResult]?) {
        view?.onGetFavorite(starWarsCharacterResult: starWarsCharacterResult)
    }
    
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld) {
        view?.onGetCustomDetailSuccess(specie: specie, homeWorld: homeWorld)
    }
    
    func onGetCustomDetailError() {
        view?.onGetCustomDetailError()
    }
}
