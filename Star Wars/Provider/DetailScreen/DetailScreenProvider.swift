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
    func getCustomDetail (pathSpecie: String, pathHomeWorld: String, sucessCallback: @escaping(Specie, HomeWorld) -> Void, failureCallback: @escaping (Error?) -> Void)
}

extension DetailScreenProvider: DetailScreenProviderProtocol {
    func getCustomDetail(pathSpecie: String, pathHomeWorld: String, sucessCallback: @escaping (Specie, HomeWorld) -> Void, failureCallback: @escaping (Error?) -> Void) {
        NetworkManager.sharedInstance.customRequest(path: pathSpecie, request: specieRequest){(response: SpecieResponse) in
            if let error = response.error {
                failureCallback(error)
                return
            }
            let specieData = response.specieDetail
            NetworkManager.sharedInstance.customRequest(path: pathHomeWorld, request: self.homeWorldRequest) { (response: HomeWorldResponse) in
                if let error = response.error {
                    failureCallback(error)
                    return
                }
                let homeWorldData = response.homeWorldDetail
                sucessCallback(specieData!, homeWorldData!)
            }
            
        }
    }
    
    
}
