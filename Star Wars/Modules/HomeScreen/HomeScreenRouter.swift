//
//  HomeScreenRouter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import UIKit

final class HomeScreenRouter: PresenterToRouterHomeScreenProtocol {
    func pushToFavoriteScreen(on view: PresenterToViewHomeScreenProtocol) {
        let favoriteScreenViewController = FavoriteScreenRouter.createModule()
        guard let viewController = view as? HomeScreenView else {return}
        viewController.navigationController?.pushViewController(favoriteScreenViewController, animated: true)
    }
    
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, starWarsCharacterResult: StarWarsCharacterResult){
        let detailScreenViewController = DetailScreenRouter.createModule(starWarsCharacterResult: starWarsCharacterResult)
        guard let viewController = view as? HomeScreenView else {return }
        viewController.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
    
    static func createModule() -> UINavigationController {
        let provider = HomeScreenProvider()
        let domain = HomeScreenDomain(provider: provider)
        let interactor = HomeScreenInteractor(domain: domain)
        let favoriteInteractor = FavoriteScreenInteractor()
        let router = HomeScreenRouter()
        domain.responseCharacterList = interactor
        
        let viewController = HomeScreenView()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = HomeScreenPresenter(view: viewController, interactor: interactor, favoriteInteractor: favoriteInteractor, router: router)
        
        interactor.delegate = presenter
        favoriteInteractor.delegate = presenter
        viewController.presenter = presenter
        return navigationController
    }
    
    
}
