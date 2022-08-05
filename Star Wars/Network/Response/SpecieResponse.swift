//
//  CustomResponse.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation

class SpecieResponse: ResponseHandler {
    
    var specieDetail: Specie?
    
    override func parseModel() throws {
        if success() {
            guard let data = data else {return}
            specieDetail = try JSONDecoder().decode(Specie.self, from: data)
        }
    }
}
