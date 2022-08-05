//
//  DetailScreenRouter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenRouter: PresenterToRouterDetailScreenProtocol {
    static func createModule(speciePath: String?, homeWorldPath: String?) -> UIViewController {
        let provider = DetailScreenProvider()
        let domain = DetailScreenDomain(provider: provider)
        let interactor = DetailScreenInteractor(domain: domain)
        
        domain.responseDetailCustom = interactor
        
        let viewController = DetailScreenView()
        
        let presenter: ViewToPresenterDetailScreenProtocol & InteractorToPresenterDetailScreenProtocol = DetailScreenPresenter()
        viewController.presenter = presenter
        viewController.presenter?.interactor = interactor
        viewController.presenter?.view = viewController
        viewController.homeWorldPath = homeWorldPath
        viewController.speciePath = speciePath
        interactor.delegate = presenter
        return viewController
    }
    
    
}
