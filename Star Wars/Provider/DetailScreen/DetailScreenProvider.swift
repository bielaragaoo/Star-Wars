//
//  DetailScreenProvider.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation

class DetailScreenProvider {
    private let specieRequest = SpecieRequest()
    private let homeWorldRequest = HomeWorldRequest()
    
}

protocol DetailScreenProviderProtocol {
    func getSpecieDetail (pathSpecie: String, sucessCallback: @escaping(Specie) -> Void, failureCallback: @escaping (Error?) -> Void)
    func getHomeWorldDetail (pathHomeWorld: String, sucessCallback: @escaping(HomeWorld) -> Void, failureCallback: @escaping (Error?) -> Void)
}

extension DetailScreenProvider: DetailScreenProviderProtocol {
    
    func getSpecieDetail(pathSpecie: String, sucessCallback: @escaping (Specie) -> Void, failureCallback: @escaping (Error?) -> Void) {
        NetworkManager.sharedInstance.customRequest(path: pathSpecie, request: specieRequest){(response: SpecieResponse) in
            if let error = response.error {
                failureCallback(error)
                return
            }
            let specieData = response.specieDetail
            
            sucessCallback(specieData!)
        }
    }
    func getHomeWorldDetail(pathHomeWorld: String, sucessCallback: @escaping (HomeWorld) -> Void, failureCallback: @escaping (Error?) -> Void) {
        NetworkManager.sharedInstance.customRequest(path: pathHomeWorld, request: self.homeWorldRequest) { (response: HomeWorldResponse) in
            if let error = response.error {
                failureCallback(error)
                return
            }
            let homeWorldData = response.homeWorldDetail
            sucessCallback(homeWorldData!)
        }
    }
    
}

