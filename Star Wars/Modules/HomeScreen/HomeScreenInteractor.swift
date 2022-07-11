//
//  HomeScreenInteractor.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation


class HomeScreenInteractor: PresenterToInteractorHomeScreenProtocol {
    
    var presenter: InteractorToPresenterHomeScreenProtocol?
    var character: StarWarsCharacter?
    
    private let domain: HomeScreenDomain
    
    init(domain: HomeScreenDomain){
    self.domain = domain
    }
    
    func getCharacters() {
        domain.getCharacterList()
    }
    
    
}
