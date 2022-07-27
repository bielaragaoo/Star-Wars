//
//  HomeScreenInteractor.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation


class HomeScreenInteractor: PresenterToInteractorHomeScreenProtocol {
    
    var character: StarWarsCharacter?
    var delegate: HomeScreenCharacterListResponseProtocol? 
    
    private let domain: HomeScreenDomain
    
    init(domain: HomeScreenDomain){
    self.domain = domain
    }
    
    func getCharacters() {
        domain.getCharacterList()
    }
}

extension HomeScreenInteractor: HomeScreenCharacterListResponseProtocol {
    func responseGetCharacterListSuccess(data: StarWarsCharacter?) {
        if let data = data {
            delegate?.responseGetCharacterListSuccess(data: data)
        } else {
            delegate?.responseGetCharacterListError(error: data as? Error)
        }
    }
    
    func responseGetCharacterListError(error: Error?) {
        delegate?.responseGetCharacterListError(error: error)
    }
    
    
}
