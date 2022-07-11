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
        labelCell.text = "ObiWan"
        labelCell.font = UIFont.systemFont(ofSize: 18)
        labelCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelCell.topAnchor.constraint(equalTo: labelCell.topAnchor, constant: 48),
            labelCell.bottomAnchor.constraint(equalTo: labelCell.bottomAnchor, constant: -48),
            labelCell.leftAnchor.constraint(equalTo: labelCell.leftAnchor, constant: 48),
            labelCell.rightAnchor.constraint(equalTo: labelCell.rightAnchor, constant: -48)])
        
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
