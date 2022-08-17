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
    var favoritePresenter: ViewToPresenterFavoriteScreenProtocol?
    var starWarsCharacterResult: StarWarsCharacterResult?
    var favoriteCharacters: [StarWarsCharacterResult]?
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
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    override func viewDidLoad() {
        if(starWarsCharacterResult?.species.first != nil) {
            presenter?.getSpecie(speciePath: (starWarsCharacterResult?.species.first ?? nil)!)
        } else {
            speciesLabel.text = "Specie: N/A"
        }
        
        if(starWarsCharacterResult?.homeWorld != nil) {
            presenter?.getHomeWorld(homeWorldPath: (starWarsCharacterResult?.homeWorld)!)
        } else {
            homeWorldLabel.text = "HomeWorld: N/A"
        }
        
        favoritePresenter?.getFavorites()
        setupLabel()
        setupUI()
    }
}

extension DetailScreenView: PresenterToViewDetailScreenProtocol{
    func onGetSpecieSuccess(specie: Specie) {
        speciesLabel.text = "Specie: \(specie.name ?? "N/A")"
    }
    
    func onGetHomeWorldSucess(homeWorld: HomeWorld) {
        homeWorldLabel.text = "Homeworld: \(homeWorld.name ?? "N/A")"
    }
    
    func onGetSpecieError() {
        print("error")
    }
    
    func onGetHomeWorldError() {
        print("error")
    }
    
    func setupLabel() {
        nameLabel.text = "Name: \(starWarsCharacterResult?.name ?? "N/A")"
        birthYearLabel.text = "Birth year: \(starWarsCharacterResult?.birthYear ?? "N/A")"
        eyeColorLabel.text = "Eye color: \(starWarsCharacterResult?.eyeColor ?? "N/A")"
        genderLabel.text = "Gender: \(starWarsCharacterResult?.gender ?? "N/A")"
        heightLabel.text = "Height: \(starWarsCharacterResult?.height ?? "N/A")"
        massLabel.text = "Mass: \(starWarsCharacterResult?.mass ?? "N/A")"
        skinColorLabel.text = "Skin color: \(starWarsCharacterResult?.skinColor ?? "N/A")"
    }
}

extension DetailScreenView {
    func setupUI(){
        view.backgroundColor = .white
        setupFavStartIcon()
        self.navigationItem.title = "Detail Screen"
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
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func fav() { // remove @objc for Swift 3
        if(favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
            character.name == starWarsCharacterResult?.name
        })){
            favoriteCharacters?.removeAll(where: { character in
                character.name == starWarsCharacterResult?.name
            })
            favoritePresenter?.saveFavorites(starWarsCharacter:favoriteCharacters ??  [] )
            setFavItem(iconName: "no-fav-icon")
        } else {
            favoriteCharacters?.append(starWarsCharacterResult!)
            favoritePresenter?.saveFavorites(starWarsCharacter: favoriteCharacters!)
            setFavItem(iconName: "fav-icon")
        }
    }
    
    func setFavItem(iconName: String) {
        favoriteIcon = UIImage(named: "\(iconName).png")?.withTintColor(UIColor.red).withRenderingMode(.alwaysOriginal) ?? UIImage()
        let favItem = UIBarButtonItem(image: favoriteIcon, style: .plain, target: self, action: #selector(fav))
        self.navigationItem.setRightBarButton(favItem, animated: false)
    }
    
    var topBarSafeArea: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    func setupFavStartIcon(){
        if(favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
            character.name == starWarsCharacterResult?.name
        })){
            setFavItem(iconName: "fav-icon")
        } else {
            setFavItem(iconName: "no-fav-icon")
        }
    }
}
extension DetailScreenView: PresenterToViewFavoriteScreenProtocol {
    func onGetFavoriteList(starWarsCharacter: [StarWarsCharacterResult]?) {
            favoriteCharacters = starWarsCharacter ?? []
    }
    
    func onSaveFavoriteListError() {
        
    }
    
    
}
