//
//  APIConfig.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation
import Alamofire

let baseUrl = "https://swapi.dev/api/"

enum EndPoint {
    case getCharacterList
}

extension EndPoint {
    private var endPoint: String {
        switch self {
        case .getCharacterList:
            return "people/?page=1"
        }
    }
    
    var fullPath: String {
        return baseUrl + endPoint
    }
    
}




