//
//  HomeScreenContract.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import UIKit

protocol PresenterToViewHomeScreenProtocol: ViewInterface {
    func reloadData()
    func showLoadingPage(show: Bool)
}

protocol ViewToPresenterHomeScreenProtocol {    
    func viewDidLoad(path: String?)
    func goToFavoriteScreen()
    func goToDetailScreen(index: Int)
    func tableViewCount() -> Int
    func charactersInfo() -> [StarWarsCharacterResult]
    func prefetchStarWarsData()
    func searchCharacters(for searchText: String?)
    func favoriteCharacter(index: Int)
    func isFavoriteCharacter(index: Int) -> Bool
    func updateInfo()
}

protocol PresenterToInteractorHomeScreenProtocol {
    
    func getCharacters(path: String?)
}

protocol PresenterToRouterHomeScreenProtocol {
    static func createModule() -> UINavigationController
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, starWarsCharacterResult: StarWarsCharacterResult)
    func pushToFavoriteScreen(on view: PresenterToViewHomeScreenProtocol)
}

protocol InteractorToPresenterHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter)
    func onGetCharacterListError()
}
