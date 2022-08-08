//
//  HomeScreenContract.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import UIKit

protocol PresenterToViewHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter)
    func onGetCharacterListError()
}

protocol ViewToPresenterHomeScreenProtocol {
    var view: PresenterToViewHomeScreenProtocol? { get set }
    var interactor: PresenterToInteractorHomeScreenProtocol? { get set }
    var router: PresenterToRouterHomeScreenProtocol? { get set }
    
    func viewDidLoad(path: String?)
}

protocol PresenterToInteractorHomeScreenProtocol {
    
    func getCharacters(path: String?)
}

protocol PresenterToRouterHomeScreenProtocol {
    static func createModule() -> UINavigationController
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, starWarsCharacterResult: StarWarsCharacterResult)
}

protocol InteractorToPresenterHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter)
    func onGetCharacterListError()
}
