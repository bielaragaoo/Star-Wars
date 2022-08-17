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
        
        domain.responseDetailCustom = interactor
        
        let viewController = DetailScreenView()
        
        let presenter: ViewToPresenterDetailScreenProtocol & InteractorToPresenterDetailScreenProtocol = DetailScreenPresenter()
        let favoritePresenter: ViewToPresenterFavoriteScreenProtocol & InteractorToPresenterFavoriteScreenProtocol = FavoriteScreenPresenter()
        viewController.favoritePresenter = favoritePresenter
        viewController.favoritePresenter?.interactor = favoriteInteractor
        viewController.favoritePresenter?.view = viewController
        viewController.presenter = presenter
        viewController.presenter?.interactor = interactor
        viewController.presenter?.view = viewController
        viewController.starWarsCharacterResult = starWarsCharacterResult
        
        interactor.delegate = presenter
        favoriteInteractor.delegate = favoritePresenter
        return viewController
    }
}
