//
//  HomeScreenInteractor.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation


class HomeScreenInteractor: PresenterToInteractorHomeScreenProtocol {
    
    var character: StarWarsCharacter?
    var delegate: InteractorToPresenterHomeScreenProtocol?
    
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
            delegate?.onGetCharacterListSucess(data)
        } else {
            delegate?.onGetCharacterListError()
            
        }
    }
    
    func responseGetCharacterListError(error: Error?) {
        delegate?.onGetCharacterListError()
    }
    
    
}
