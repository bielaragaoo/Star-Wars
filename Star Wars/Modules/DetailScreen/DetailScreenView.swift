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
    var starWarsCharacterResult: StarWarsCharacterResult?
    var nameLabel =  UILabel()
    var birthYearLabel = UILabel()
    var eyeColorLabel = UILabel()
    var genderLabel = UILabel()
    var homeWorldLabel = UILabel()
    var speciesLabel = UILabel()
    var heightLabel = UILabel()
    var massLabel = UILabel()
    var skinColorLabel = UILabel()
    var favoriteIcon = UIImage()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    override func viewDidLoad() {
        if(starWarsCharacterResult?.species.first != nil && starWarsCharacterResult?.homeWorld != nil) {
            presenter?.getCustomDetail(speciePath: (starWarsCharacterResult?.species.first!)!, homeWorldPath: (starWarsCharacterResult?.homeWorld!)! )
        }
        setupUI()
    }
}

extension DetailScreenView: PresenterToViewDetailScreenProtocol{
    
    func onGetCustomDetailSuccess(specie: Specie, homeWorld: HomeWorld) {
        nameLabel.text = "Nome: \(starWarsCharacterResult?.name ?? "N/A")"
        birthYearLabel.text = "Data de nascimento: \(starWarsCharacterResult?.birthYear ?? "N/A")"
        eyeColorLabel.text = "Cor do olho: \(starWarsCharacterResult?.eyeColor ?? "N/A")"
        genderLabel.text = "Gênero: \(starWarsCharacterResult?.gender ?? "N/A")"
        homeWorldLabel.text = "Pais de nascença: \(homeWorld.name ?? "N/A")"
        speciesLabel.text = "Espécie: \(specie.name ?? "N/A")"
        heightLabel.text = "Altura: \(starWarsCharacterResult?.height ?? "N/A")"
        massLabel.text = "Peso: \(starWarsCharacterResult?.mass ?? "N/A")"
        skinColorLabel.text = "Cor de pele: \(starWarsCharacterResult?.skinColor ?? "N/A")"
    }
    
    func onGetCustomDetailError() {
        print("error")
    }
}

extension DetailScreenView {
    func setupUI(){
        view.backgroundColor = .white
        let navBar = configurateNavBar()
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(birthYearLabel)
        stackView.addArrangedSubview(eyeColorLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(homeWorldLabel)
        stackView.addArrangedSubview(speciesLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(massLabel)
        stackView.addArrangedSubview(skinColorLabel)
        view.addSubview(stackView)
        view.addSubview(navBar)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configurateNavBar() -> UINavigationBar{
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: topBarSafeArea, width: view.frame.size.width, height: 44))
        favoriteIcon = UIImage(named: "no_favorite_icon.png")?.withTintColor(UIColor.black).withRenderingMode(.alwaysOriginal) ?? UIImage()
        let navItem = UINavigationItem(title: "Detail Screen")
        let favItem = UIBarButtonItem(image: favoriteIcon, style: .plain, target: self, action: #selector(fav))
        navBar.barTintColor = UIColor.white
        navItem.rightBarButtonItem = favItem
        navBar.setItems([navItem], animated: false)
        return navBar
    }
    @objc func fav() { // remove @objc for Swift 3

    }
    var topBarSafeArea: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        }
}
