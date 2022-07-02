//
//  CharacterListRequest.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

class CharacterListRequest: RequestHandler{
    func path() -> String {
        return EndPoint.getCharacterList.fullPath
    }
    func httpMethod() -> RequestMethod {
        return .get
    }
}
