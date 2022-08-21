//
//  FavoriteScreenRouter.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import Foundation
import UIKit
class FavoriteScreenRouter: PresenterToRouterFavoriteScreenProtocol{
    static func createModule() -> UIViewController {
        
        let interactor = FavoriteScreenInteractor()
        let viewController = FavoriteScreenView()
        let router = FavoriteScreenRouter()
        let presenter = FavoriteScreenPresenter(router: router, view: viewController, interactor: interactor)
        
        
        interactor.delegate = presenter
        viewController.presenter = presenter
        
        return viewController
    }
    
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, starWarsCharacterResult: StarWarsCharacterResult) {
        let detailScreenViewController = DetailScreenRouter.createModule(starWarsCharacterResult: starWarsCharacterResult)
        guard let viewController = view as? HomeScreenView else {return }
        viewController.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
    
    
}
