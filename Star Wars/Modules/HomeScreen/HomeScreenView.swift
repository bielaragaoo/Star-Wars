//
//  HomeScreenView.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import UIKit

class HomeScreenView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var presenter: ViewToPresenterHomeScreenProtocol?
    var label: String?
    var identifier = "Cell reuse identifier"
    func setup (starWarsCharacter: StarWarsCharacter) {
        label = starWarsCharacter.result?.first?.name
        print("label: \(label)")
        
    }
    
    func tableView(_ characterListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ characterListTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = characterListTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeScreenViewTableViewCell
        cell.label.text = label
        return cell
    }
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        characterListTableView.delegate = self
        characterListTableView.dataSource = self
        characterListTableView.register(HomeScreenViewTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
}

extension HomeScreenView: PresenterToViewHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        lazy var loginView: HomeScreenView = {
            let view = HomeScreenView()
            view.setup(starWarsCharacter: starWarsCharacter)
            return view
        }()
    }
    
    func onGetCharacterListError(_ error: Error) {
        
    }
}
