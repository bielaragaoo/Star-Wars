//
//  SpecieRequest.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation

class SpecieRequest: RequestHandler{
    func path() -> String {
        return EndPoint.getCharacterList.fullPath
    }
    func httpMethod() -> RequestMethod {
        return .get
    }
}
