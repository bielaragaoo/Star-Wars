//
//  HomeScreenViewController.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    
    var presenter: ViewToPresenterHomeScreenProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
}

extension HomeScreenViewController: PresenterToViewHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        lazy var loginView: HomeScreenView = {
            let view = HomeScreenView()
            view.setup(starWarsCharacter: starWarsCharacter)
            return view
        }()
    }
    
    func onGetCharacterListError(_ starWarsCharacter: StarWarsCharacter) {
        
    }
}


