//
//  DetailScreenContract.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

protocol PresenterToInteractorDetailScreenProtocol{
    func getCustomDetail(speciePath: String, homeWorldPath: String)
    func saveFavorite(starWarsCharacterResult: [StarWarsCharacterResult])
    func getFavorite()
}

protocol InteractorToPresenterDetailScreenProtocol{
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld)
    func onGetCustomDetailError()
    func onGetFavorites(starWarsCharacterResult: [StarWarsCharacterResult]?)
}

protocol PresenterToViewDetailScreenProtocol {
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld)
    func onGetCustomDetailError()
    func onGetFavorite(starWarsCharacterResult: [StarWarsCharacterResult]?)
}

protocol ViewToPresenterDetailScreenProtocol {
    var view: PresenterToViewDetailScreenProtocol? { get set }
    var interactor: PresenterToInteractorDetailScreenProtocol? { get set }
    var router: PresenterToRouterDetailScreenProtocol? { get set }
    
    func getCustomDetail(speciePath: String, homeWorldPath: String)
    func getFavorite()
    func saveFavorite(starWarsCharacterResult: [StarWarsCharacterResult])
}

protocol PresenterToRouterDetailScreenProtocol {
    static func createModule(starWarsCharacterResult: StarWarsCharacterResult) -> UIViewController
}
