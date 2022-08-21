//
//  HomeScreenPresenter.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 02/07/22.
//

import Foundation

class HomeScreenPresenter: ViewToPresenterHomeScreenProtocol {
    private var view: PresenterToViewHomeScreenProtocol
    
    private var interactor: PresenterToInteractorHomeScreenProtocol
    
    private var favoriteInteractor: PresenterToInteractorFavoriteScreenProtocol
    
    private var router: PresenterToRouterHomeScreenProtocol
    
    private var characters: [StarWarsCharacterResult]?
    
    private var filterCharacters: [StarWarsCharacterResult]?
    
    private var favoriteCharacters: [StarWarsCharacterResult]?
    
    private var searchText: String?
    
    private var nextPage: String?
    
    private var apiResult: StarWarsCharacter?
    
    private let searchMinimumCount = 1
    
    init(view: PresenterToViewHomeScreenProtocol, interactor: PresenterToInteractorHomeScreenProtocol, favoriteInteractor: PresenterToInteractorFavoriteScreenProtocol, router: PresenterToRouterHomeScreenProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.favoriteInteractor = favoriteInteractor
    }
    
    func viewDidLoad(path: String?) {
        view.showLoadingPage(show: true)
        interactor.getCharacters(path: path)
        favoriteInteractor.getFavorites()
    }
    
    func goToFavoriteScreen() {
        router.pushToFavoriteScreen(on: view)
    }
    
    func goToDetailScreen(index: Int) {
        router.pushToDetailScreen(on: view, starWarsCharacterResult: (characters ?? [])[index])
    }
    
    func tableViewCount() -> Int {
        if(hasFilteredCharacters()){
            return (filterCharacters ?? []).count
        } else {
            return (characters ?? []).count
        }
    }
    
    func charactersInfo() -> [StarWarsCharacterResult] {
        if(hasFilteredCharacters()){
            return filterCharacters ?? []
        } else {
            return characters ?? []
        }
    }
    
    func prefetchStarWarsData() {
        if(apiResult?.next != nextPage) {
            interactor.getCharacters(path: apiResult?.next ?? "")
            nextPage = apiResult?.next
        }
    }
    
    func searchCharacters(for searchText: String?) {
        if (searchText ?? "").count > searchMinimumCount {
            filterCharacters = characters?.filter{(filterCharacter) -> Bool in (filterCharacter.name ?? "").contains(searchText ?? "")}
        } else {
            filterCharacters = []
        }
        self.searchText = searchText
        view.reloadData()
    }
    
    func favoriteCharacter(index: Int) {
        if(isFavorited(index: index)){
            favoriteCharacters?.removeAll(where: { element in
                element.name == charactersInfo()[index].name
            })
            favoriteInteractor.saveFavorites(starWarsCharacter: favoriteCharacters ?? [])
        } else {
            favoriteCharacters?.append(charactersInfo()[index])
            favoriteInteractor.getFavorites()
        }
    }
    
    func isFavoriteCharacter(index: Int) -> Bool{
        return isFavorited(index: index)
    }
}

extension HomeScreenPresenter: InteractorToPresenterHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        if var actualCharacters = characters {
            actualCharacters += starWarsCharacter.results
            characters = actualCharacters
        } else {
            characters = starWarsCharacter.results
        }
        apiResult = starWarsCharacter
        view.reloadData()
        view.showLoadingPage(show: false)
        
    }
    
    func onGetCharacterListError() {
    }
    
}

extension HomeScreenPresenter: InteractorToPresenterFavoriteScreenProtocol{
    func onGetFavoriteList(favoriteList: [StarWarsCharacterResult]?) {
        favoriteCharacters = favoriteList
        view.reloadData()
    }
    
    func onSaveCharacterListError() {
        
    }
}

private extension HomeScreenPresenter {
    func hasFilteredCharacters() -> Bool{
        if((filterCharacters ?? []).isEmpty && !((searchText ?? "").count > searchMinimumCount)){
            return false
        } else {
            return true
        }
    }
    
    func isFavorited(index: Int) -> Bool {
        guard let isFavorite =  favoriteCharacters?.contains(where: { element in
            element.name == charactersInfo()[index].name
        }) else {return false}
        return isFavorite
    }
}

