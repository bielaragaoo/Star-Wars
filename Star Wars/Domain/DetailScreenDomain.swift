//
//  DetailScreenDomain.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation

protocol DetailScreenDomainProtocol {
    func getCustomDetail (speciePath: String, homeWorldPath: String)
}

protocol DetailScreenResponseProtocol: AnyObject {
    func responseCustomDetailSuccess(specieData: Specie, homeWorldData: HomeWorld)
    func responseCustomDetailError(error: Error?)
}

final class DetailScreenDomain {
    
    weak var responseDetailCustom: DetailScreenResponseProtocol?
    
    var provider: DetailScreenProviderProtocol!
    
    init(provider: DetailScreenProviderProtocol){
    self.provider = provider
    }
}

extension DetailScreenDomain: DetailScreenDomainProtocol {
    func getCustomDetail(speciePath: String, homeWorldPath: String) {
        provider.getCustomDetail(pathSpecie: speciePath, pathHomeWorld: homeWorldPath) { specie, homeWorld in
            self.responseDetailCustom?.responseCustomDetailSuccess(specieData: specie, homeWorldData: homeWorld)
        } failureCallback: { error in
            self.responseDetailCustom?.responseCustomDetailError(error: error)
        }
    }
}
