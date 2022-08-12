//
//  DetailScreenDomain.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation

protocol DetailScreenDomainProtocol {
    func getSpecieDetail (speciePath: String)
    func getHomeWorldDetail (homeWorldPath: String)
}

protocol DetailScreenResponseProtocol: AnyObject {
    func responseSpecieSucess(specieData: Specie)
    func responseHomeWorldSucess(homeWorldData: HomeWorld)
   
    func responseSpecieError(error: Error?)
    func responseHomeWorldError(error: Error?)
}

final class DetailScreenDomain {
    
    weak var responseDetailCustom: DetailScreenResponseProtocol?
    
    var provider: DetailScreenProviderProtocol!
    
    init(provider: DetailScreenProviderProtocol){
    self.provider = provider
    }
}

extension DetailScreenDomain: DetailScreenDomainProtocol {
    func getHomeWorldDetail(homeWorldPath: String) {
        provider.getHomeWorldDetail(pathHomeWorld: homeWorldPath){ homeWorld in
            self.responseDetailCustom?.responseHomeWorldSucess(homeWorldData: homeWorld)
        } failureCallback: { error in
            self.responseDetailCustom?.responseHomeWorldError(error: error)
        }
    }

    func getSpecieDetail(speciePath: String) {
        provider.getSpecieDetail(pathSpecie: speciePath) { specie in
            self.responseDetailCustom?.responseSpecieSucess(specieData: specie)
        } failureCallback: { error in
            self.responseDetailCustom?.responseSpecieError(error: error)
        }
    }
}
