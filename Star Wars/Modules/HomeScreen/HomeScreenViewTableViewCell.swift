//
//  HomeScreenViewTableViewCell.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import Foundation
import UIKit

protocol favoriteCellProtocol {
    func onFavoritePress(index: Int)
}

class HomeScreenViewTableViewCell: UITableViewCell {
    var identifier = "Cell reuse identifier"
    let labelName = UILabel()
    var delegate: favoriteCellProtocol?
    let labelHeight = UILabel()
    let labelBirthYear = UILabel()
    var characterIndex: Int = 0
    let favoriteButton = UIButton(type: .system)
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    @objc func favorite () {
        delegate?.onFavoritePress(index: characterIndex)
    }
    
    func configureCell(){
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(labelName)
        stackView.addArrangedSubview(labelHeight)
        stackView.addArrangedSubview(labelBirthYear)
        contentView.addSubview(favoriteButton)
        
        
        favoriteButton.addTarget(self, action: #selector(favorite), for: .touchUpInside)
//        favoriteButton.setImage(UIImage(named: isFavorite ? "fav-icon" : "no-fav-icon"), for: .normal)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelHeight.translatesAutoresizingMaskIntoConstraints = false
        labelBirthYear.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        favoriteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        favoriteButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    func setup(starData: StarWarsCharacterResult?, index: Int, isCharacterFavorite: Bool) {
        labelName.text = starData?.name
        labelHeight.text = starData?.height
        labelBirthYear.text = starData?.birthYear
        favoriteButton.setImage(UIImage(named: isCharacterFavorite ? "fav-icon" : "no-fav-icon"), for: .normal)
        characterIndex = index
    }
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
