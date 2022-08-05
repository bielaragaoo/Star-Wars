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
    let labelName = UILabel()
    let labelHeight = UILabel()
    let labelBirthYear = UILabel()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    func configureCell(){
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(labelName)
        stackView.addArrangedSubview(labelHeight)
        stackView.addArrangedSubview(labelBirthYear)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelHeight.translatesAutoresizingMaskIntoConstraints = false
        labelBirthYear.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    func setup(starData: StarWarsCharacterResult?) {
        labelName.text = starData?.name
        labelHeight.text = starData?.height
        labelBirthYear.text = starData?.birthYear
    }
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
