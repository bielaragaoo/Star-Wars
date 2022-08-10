//
//  DetailScreenInteractor.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenInteractor: PresenterToInteractorDetailScreenProtocol {
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
    
    func getCustomDetail(speciePath: String, homeWorldPath: String) {
        domain.getCustomDetail(speciePath: speciePath, homeWorldPath: homeWorldPath)
    }
}

extension DetailScreenInteractor: DetailScreenResponseProtocol{
    func responseCustomDetailSuccess(specieData: Specie, homeWorldData: HomeWorld) {
        delegate?.onGetCustomDetailSuccess(specie: specieData, homeWorld: homeWorldData)
    }
    
    func responseCustomDetailError(error: Error?) {
        delegate?.onGetCustomDetailError()
    }
}
