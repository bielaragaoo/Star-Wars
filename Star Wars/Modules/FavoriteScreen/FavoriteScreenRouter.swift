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
            let presenter: ViewToPresenterFavoriteScreenProtocol & InteractorToPresenterFavoriteScreenProtocol = FavoriteScreenPresenter()
            viewController.presenter = presenter
            viewController.presenter?.interactor = interactor
            viewController.presenter?.view = viewController
            
            interactor.delegate = presenter
        
            return viewController
    }
    
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, starWarsCharacterResult: StarWarsCharacterResult) {
        let detailScreenViewController = DetailScreenRouter.createModule(starWarsCharacterResult: starWarsCharacterResult)
        let viewController = view as! HomeScreenView
        viewController.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
    
    
}
