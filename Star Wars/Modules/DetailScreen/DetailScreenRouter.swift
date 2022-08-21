//
//  DetailScreenRouter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenRouter: PresenterToRouterDetailScreenProtocol {
    static func createModule(starWarsCharacterResult: StarWarsCharacterResult) -> UIViewController {
        let provider = DetailScreenProvider()
        let domain = DetailScreenDomain(provider: provider)
        let interactor = DetailScreenInteractor(domain: domain)
        let favoriteInteractor = FavoriteScreenInteractor()
        let router = DetailScreenRouter()
        
        domain.responseDetailCustom = interactor
        
        let viewController = DetailScreenView()
        
        let presenter = DetailScreenPresenter(router: router, view: viewController, interactor: interactor, favoriteInteractor: favoriteInteractor)
        
        interactor.delegate = presenter
        favoriteInteractor.delegate = presenter
        viewController.presenter = presenter
        presenter.starWarsCharacterResult = starWarsCharacterResult
        return viewController
    }
}
