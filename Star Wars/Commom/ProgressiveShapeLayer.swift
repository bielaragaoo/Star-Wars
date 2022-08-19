//
//  ProgressiveShapeLayer.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 18/08/22.
//

import Foundation
import UIKit

class ProgressiveShapeLayer: CAShapeLayer {
    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
