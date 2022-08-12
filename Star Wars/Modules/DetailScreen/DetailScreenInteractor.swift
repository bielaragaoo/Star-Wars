//
//  DetailScreenInteractor.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenInteractor: PresenterToInteractorDetailScreenProtocol {
    func getSpecie(speciePath: String) {
        domain.getSpecieDetail(speciePath: speciePath)
    }
    
    func getHomeWorld(homeWorldPath: String) {
        domain.getHomeWorldDetail(homeWorldPath: homeWorldPath)
    }
    
    var delegate: InteractorToPresenterDetailScreenProtocol?
    private let domain: DetailScreenDomain
    init(domain: DetailScreenDomain){
        self.domain = domain
    }
    
    func saveFavorite(starWarsCharacterResult: [StarWarsCharacterResult]) {
        do{
           try LocalDatabaseManager.sharedInstance.saveFavorite(starWarsCharacterResult: starWarsCharacterResult)
            self.getFavorite()
        } catch {
            print("error saving character list")
        }
    }
    
    func getFavorite() {
        do {
         let characterList = try LocalDatabaseManager.sharedInstance.getFavorites() as [StarWarsCharacterResult]
            delegate?.onGetFavorites(starWarsCharacterResult: characterList)
        } catch {
            delegate?.onGetFavorites(starWarsCharacterResult: [])
        }
    }
}

extension DetailScreenInteractor: DetailScreenResponseProtocol{
    func responseSpecieSucess(specieData: Specie) {
        delegate?.onGetSpecieSuccess(specie: specieData)
    }
    
    func responseHomeWorldSucess(homeWorldData: HomeWorld) {
        delegate?.onGetHomeWorldSuccess(homeWorld: homeWorldData)
    }
    
    func responseSpecieError(error: Error?) {
        delegate?.onGetSpecieError()
    }
    
    func responseHomeWorldError(error: Error?) {
        delegate?.onGetHomeWorldError()
    }
}
