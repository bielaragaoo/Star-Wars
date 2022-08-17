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

protocol PresenterToViewDetailScreenProtocol {
    func onGetSpecieSuccess(specie: Specie)
    func onGetHomeWorldSucess (homeWorld: HomeWorld)
    func onGetSpecieError()
    func onGetHomeWorldError()
}

protocol ViewToPresenterDetailScreenProtocol {
    var view: PresenterToViewDetailScreenProtocol? { get set }
    var interactor: PresenterToInteractorDetailScreenProtocol? { get set }
    var router: PresenterToRouterDetailScreenProtocol? { get set }
    
    func getSpecie(speciePath: String)
    func getHomeWorld(homeWorldPath: String)
}

protocol PresenterToRouterDetailScreenProtocol {
    static func createModule(starWarsCharacterResult: StarWarsCharacterResult) -> UIViewController
}
