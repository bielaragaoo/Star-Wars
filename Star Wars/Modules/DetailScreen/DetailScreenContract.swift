//
//  DetailScreenContract.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

protocol PresenterToInteractorDetailScreenProtocol{
    func getSpecie(speciePath: String)
    func getHomeWorld(homeWorldPath: String)
}

protocol InteractorToPresenterDetailScreenProtocol{
    func onGetSpecieSuccess(specie: Specie)
    func onGetHomeWorldSuccess (homeWorld: HomeWorld)
    func onGetSpecieError()
    func onGetHomeWorldError()
}

protocol PresenterToViewDetailScreenProtocol: ViewInterface {
    func showLoadingPage(show: Bool)
    func onGetSpecieError()
    func onGetHomeWorldError()
    func setupLabels(starWarsCharactersResult: StarWarsCharacterResult?, specieName: String, homeworldName: String)
    func changeFavIconStatus(isFavorite: Bool)
}

protocol ViewToPresenterDetailScreenProtocol {
    var starWarsCharacterResult: StarWarsCharacterResult? {get}
    func getSpecie()
    func getHomeWorld()
    func onFavPressed()
    func isFavorite() -> Bool
    func getFavoriteCharacters()
}

protocol PresenterToRouterDetailScreenProtocol {
    static func createModule(starWarsCharacterResult: StarWarsCharacterResult) -> UIViewController
}
