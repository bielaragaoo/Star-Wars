//
//  HomeScreenRouter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import UIKit

class HomeScreenRouter: PresenterToRouterHomeScreenProtocol {
    static func createModule() -> UINavigationController {
        let provider = HomeScreenProvider()
        let domain = HomeScreenDomain(provider: provider)
        let interactor = HomeScreenInteractor(domain: domain)
        
        
        domain.responseCharacterList = interactor as? HomeScreenCharacterListResponseProtocol
        
        let viewController = HomeScreenView()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterHomeScreenProtocol & HomeScreenCharacterListResponseProtocol = HomeScreenPresenter()
        viewController.presenter = presenter
        viewController.presenter?.interactor = interactor
        interactor.delegate = interactor
      
        return navigationController
    }
    
    
}
