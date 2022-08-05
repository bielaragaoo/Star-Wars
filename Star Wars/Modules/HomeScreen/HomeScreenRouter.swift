//
//  HomeScreenRouter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import UIKit

class HomeScreenRouter: PresenterToRouterHomeScreenProtocol {
    func pushToDetailScreen(on view: PresenterToViewHomeScreenProtocol, speciePath: String?, homeWorldPath: String?){
        let detailScreenViewController = DetailScreenRouter.createModule(speciePath: speciePath, homeWorldPath: homeWorldPath)
        let viewController = view as! HomeScreenView
        viewController.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
    
    static func createModule() -> UINavigationController {
        let provider = HomeScreenProvider()
        let domain = HomeScreenDomain(provider: provider)
        let interactor = HomeScreenInteractor(domain: domain)
        
        
        domain.responseCharacterList = interactor
        
        let viewController = HomeScreenView()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterHomeScreenProtocol & InteractorToPresenterHomeScreenProtocol = HomeScreenPresenter()
        viewController.presenter = presenter
        viewController.presenter?.interactor = interactor
        viewController.presenter?.view = viewController
        viewController.presenter?.router = HomeScreenRouter()
        interactor.delegate = presenter
        
      
        return navigationController
    }
    
    
}
