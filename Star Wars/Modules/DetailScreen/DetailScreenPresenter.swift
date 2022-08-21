//
//  DetailScreenPresenter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 04/08/22.
//

import Foundation
import UIKit

class DetailScreenPresenter: ViewToPresenterDetailScreenProtocol {
    var starWarsCharacterResult: StarWarsCharacterResult?
    private var router: PresenterToRouterDetailScreenProtocol
    private var view: PresenterToViewDetailScreenProtocol
    private var interactor: PresenterToInteractorDetailScreenProtocol
    private var favoriteInteractor: PresenterToInteractorFavoriteScreenProtocol
    private var favoriteCharacter: [StarWarsCharacterResult]?
    private var homeworldName: String? {
        didSet{
            requestsCompleted()
        }
    }
    
    private var specieName: String? {
        didSet{
            requestsCompleted()
        }
    }
    
    init(router: PresenterToRouterDetailScreenProtocol, view: PresenterToViewDetailScreenProtocol, interactor: PresenterToInteractorDetailScreenProtocol, favoriteInteractor: PresenterToInteractorFavoriteScreenProtocol){
        self.view = view
        self.router = router
        self.interactor = interactor
        self.favoriteInteractor = favoriteInteractor
    }
    
    func getSpecie() {
        view.showLoadingPage(show: true)
        if let species = starWarsCharacterResult?.species?.first {
            interactor.getSpecie(speciePath: species)
        } else {
            specieName = "N/A"
        }
    }
    
    func getHomeWorld() {
        if let homeworld = starWarsCharacterResult?.homeWorld {
            interactor.getHomeWorld(homeWorldPath: homeworld)
        } else {
            homeworldName = "N/A"
        }
    }
    
    func onFavPressed() {
        guard let character = starWarsCharacterResult else {return}
        if(isFavorite()){
            favoriteCharacter?.removeAll(where: { character in
                character.name == starWarsCharacterResult?.name
            })
        } else {
            favoriteCharacter?.append(character)
        }
        view.changeFavIconStatus(isFavorite: isFavorite())
    }
    
    func isFavorite() -> Bool {
        guard let isFavorited = favoriteCharacter?.contains(where: { element in
            element.name == (starWarsCharacterResult?.name ?? "")
        }) else {return false}
        
        return isFavorited
    }
    
    func getFavoriteCharacters() {
        favoriteInteractor.getFavorites()
    }
    
}

extension DetailScreenPresenter: InteractorToPresenterDetailScreenProtocol{
    func onGetHomeWorldSuccess(homeWorld: HomeWorld) {
        homeworldName = homeWorld.name
    }
    
    func onGetSpecieSuccess(specie: Specie) {
        specieName = specie.name
    }
    
    func onGetSpecieError() {
        view.onGetSpecieError()
    }
    
    func onGetHomeWorldError() {
        view.onGetHomeWorldError()
    }
}

extension DetailScreenPresenter: InteractorToPresenterFavoriteScreenProtocol {
    func onGetFavoriteList(favoriteList: [StarWarsCharacterResult]?) {
        favoriteCharacter = favoriteList
    }
    
    func onSaveCharacterListError() {
        print("favorite error")
    }
    
    
}

private extension DetailScreenPresenter{
     func requestsCompleted(){
        if(specieName != nil && homeworldName != nil) {
            view.setupLabels(starWarsCharactersResult: starWarsCharacterResult, specieName: specieName ?? "N/A", homeworldName: homeworldName ?? "N/A")
            view.showLoadingPage(show: false)
        }
    }
}
