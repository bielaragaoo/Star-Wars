//
//  DetailScreenContract.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

protocol PresenterToInteractorDetailScreenProtocol{
    func getCustomDetail(speciePath: String, homeWorldPath: String)
}

protocol InteractorToPresenterDetailScreenProtocol{
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld)
    func onGetCustomDetailError()
}

protocol PresenterToViewDetailScreenProtocol {
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld)
    func onGetCustomDetailError()
}

protocol ViewToPresenterDetailScreenProtocol {
    var view: PresenterToViewDetailScreenProtocol? { get set }
    var interactor: PresenterToInteractorDetailScreenProtocol? { get set }
    var router: PresenterToRouterDetailScreenProtocol? { get set }
    
    func getCustomDetail(speciePath: String, homeWorldPath: String)
}

protocol PresenterToRouterDetailScreenProtocol {
    static func createModule(speciePath: String?, homeWorldPath: String?) -> UIViewController
}
