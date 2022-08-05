//
//  HomeWorldResponse.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation

class HomeWorldResponse: ResponseHandler {
    
    var homeWorldDetail: HomeWorld?
    
    override func parseModel() throws {
        if success() {
            guard let data = data else {return}
            homeWorldDetail = try JSONDecoder().decode(HomeWorld.self, from: data)
        }
    }
}
