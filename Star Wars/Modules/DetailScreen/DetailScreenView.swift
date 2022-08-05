//
//  DetailScreenView.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenView: UIViewController {
    var presenter: ViewToPresenterDetailScreenProtocol?
    var speciePath: String?
    var homeWorldPath: String?
    
    override func viewDidLoad() {
        if(speciePath != nil && homeWorldPath != nil) {
            presenter?.getCustomDetail(speciePath: speciePath!, homeWorldPath: homeWorldPath!)
        }
        
    }
}

extension DetailScreenView: PresenterToViewDetailScreenProtocol{
    
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld) {
        print(specie.name)
    }
    
    func onGetCustomDetailError() {
        print("error")
    }
}
