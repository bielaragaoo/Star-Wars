//
//  HomeScreenDomain.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

protocol HomeScreenDomainProtocol: AnyObject {
    func getCharacterList()
}

protocol HomeScreenCharacterListResponseProtocol: AnyObject {
    func responseGetCharacterListSuccess(data: StarWarsCharacter?)
    func responseGetCharacterListError(error: Error?)
}

final class HomeScreenDomain {
    
    weak var responseCharacterList: HomeScreenCharacterListResponseProtocol?
    
    var provider: HomeScreenProviderProtocol!
    
    init(provider: HomeScreenProviderProtocol){
    self.provider = provider
    }
}

extension HomeScreenDomain: HomeScreenDomainProtocol {
    func getCharacterList() {
        provider.getCharacterList { starWarsCharacter in
            self.responseCharacterList?.responseGetCharacterListSuccess(data: starWarsCharacter)
        } failureCallback: { error in
            self.responseCharacterList?.responseGetCharacterListError(error: error)
        }

    }
    
    
}
