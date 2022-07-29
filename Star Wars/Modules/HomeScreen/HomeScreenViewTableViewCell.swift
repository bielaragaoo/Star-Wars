//
//  HomeScreenViewTableViewCell.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import Foundation
import UIKit

class HomeScreenViewTableViewCell: UITableViewCell {
    var identifier = "Cell reuse identifier"

    var label: UILabel = {
        
        let labelCell = UILabel()
        labelCell.font = UIFont.systemFont(ofSize: 18)
        labelCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelCell.centerYAnchor.constraint(equalTo: labelCell.centerYAnchor),
            labelCell.centerXAnchor.constraint(equalTo: labelCell.centerXAnchor)

          ])
        
        return labelCell
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        addSubview(label)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    
}
