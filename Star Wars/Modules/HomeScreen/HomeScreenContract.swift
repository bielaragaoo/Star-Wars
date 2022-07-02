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
    func onGetCharacterListError(_ starWarsCharacter: StarWarsCharacter)
}

protocol ViewToPresenterHomeScreenProtocol {
    var view: PresenterToViewHomeScreenProtocol? { get set }
    var interactor: InteractorToPresenterHomeScreenProtocol? { get set }
    var router: PresenterToRouterHomeScreenProtocol? { get set }
    
    func viewDidLoad()
}

protocol PresenterToInteractorHomeScreenProtocol {
    var presenter: InteractorToPresenterHomeScreenProtocol? { get set }
    var character: StarWarsCharacter? { get set }
    
    func getCharacters()
}

protocol PresenterToRouterHomeScreenProtocol {
    static func createModule(with starWarsCharacter: StarWarsCharacter)
}

protocol InteractorToPresenterHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter)
    func onGetCharacterListError(_ starWarsCharacter: StarWarsCharacter)
}
