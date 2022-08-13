//
//  ViewInterface.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 12/08/22.
//

import UIKit
protocol ViewInterface: AnyObject {
    func showLoading(showLoading: Bool)
}

extension ViewInterface where Self: UIViewController {
    
    func showLoading(showLoading: Bool) {
        
        let tag = 99
        if showLoading {
            let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            view.backgroundColor = UIColor.white
            view.tag = tag
            
            let activityIndicator = UIActivityIndicatorView()
            
            activityIndicator.startAnimating()
            activityIndicator.color = .black
            view.addSubview(activityIndicator)
            
            activityIndicator.center =  view.center
            
            self.view.addSubview(view)
            
        } else {
            for views in self.view.subviews where views.tag == tag {
                for activity in views.subviews where activity is UIActivityIndicatorView {
                    views.removeFromSuperview()
                }
            }
        }
    }
}
