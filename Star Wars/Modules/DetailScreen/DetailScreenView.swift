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
    lazy private var nameLabel =  UILabel()
    lazy private var birthYearLabel = UILabel()
    lazy private var eyeColorLabel = UILabel()
    lazy private var genderLabel = UILabel()
    lazy private var homeWorldLabel = UILabel()
    lazy private var speciesLabel = UILabel()
    lazy private var heightLabel = UILabel()
    lazy private var massLabel = UILabel()
    lazy private var skinColorLabel = UILabel()
    lazy private var favoriteIcon = UIImage()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    override func viewDidLoad() {
        presenter?.getHomeWorld()
        presenter?.getSpecie()
        presenter?.getFavoriteCharacters()
        setupUI()
    }
}

extension DetailScreenView: PresenterToViewDetailScreenProtocol{
    func changeFavIconStatus(isFavorite: Bool) {
        setFavItem(iconName: isFavorite ? "fav-icon" : "no-fav-icon")
    }
    
    func setupLabels(starWarsCharactersResult: StarWarsCharacterResult?, specieName: String, homeworldName: String) {
        setupLabel(starWarsCharacterResult: starWarsCharactersResult, specieName: specieName, homeworldName: homeworldName)
    }
    
    
    func showLoadingPage(show: Bool) {
        showLoading(showLoading: show)
    }
    
    func onGetSpecieError() {
        print("error")
    }
    
    func onGetHomeWorldError() {
        print("error")
    }
    
    func setupLabel(starWarsCharacterResult: StarWarsCharacterResult?, specieName: String, homeworldName: String) {
        nameLabel.text = "Name: \(starWarsCharacterResult?.name ?? "N/A")"
        birthYearLabel.text = "Birth year: \(starWarsCharacterResult?.birthYear ?? "N/A")"
        eyeColorLabel.text = "Eye color: \(starWarsCharacterResult?.eyeColor ?? "N/A")"
        genderLabel.text = "Gender: \(starWarsCharacterResult?.gender ?? "N/A")"
        heightLabel.text = "Height: \(starWarsCharacterResult?.height ?? "N/A")"
        massLabel.text = "Mass: \(starWarsCharacterResult?.mass ?? "N/A")"
        skinColorLabel.text = "Skin color: \(starWarsCharacterResult?.skinColor ?? "N/A")"
        speciesLabel.text = "Specie: \(specieName)"
        homeWorldLabel.text = "Homeworld: \(homeworldName)"
    }
}

private extension DetailScreenView {
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
        presenter?.onFavPressed()
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
        guard let isFavorite = presenter?.isFavorite() else {return }
        if(isFavorite){
            setFavItem(iconName: "fav-icon")
        } else {
            setFavItem(iconName: "no-fav-icon")
        }
    }
}

