//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class CharactersViewController: RootViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: BlackSearchBar!
    private var viewModel: CharactersViewModelType = CharactersViewModel()
    private var filteredCharacters: [Character] = []
    var cachedCharacters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator(center: self.view.center)
        searchBar.delegate = self
        getCharacters()
    }

    func getCharacters() {
        startActivityIndicator()
        viewModel.fetchCharacters(completion: { response in
            switch response {
            case let .success(characters):
                self.loadData(characters: characters)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        })
    }

    func loadData(characters: [Character]) {
        cachedCharacters = characters
        filteredCharacters = cachedCharacters
        reload(tableView: tableView)
        stopActivityIndicator()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        filteredCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(viewModel: CharacterViewModel(character: filteredCharacters[indexPath.row]))

        return cell
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = viewModel.filtering(characters: cachedCharacters, target: searchText)
        reload(tableView: tableView)
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filteredCharacters = cachedCharacters
        searchBar.resignFirstResponder()
        reload(tableView: tableView)
    }
}

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cultureLabel: UILabel!
    @IBOutlet var bornLabel: UILabel!
    @IBOutlet var diedLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    
    override func prepareForReuse() {
        nameLabel.text = ""
        cultureLabel.text = ""
        bornLabel.text = ""
        diedLabel.text = ""
        seasonLabel.text = ""
    }
    
    func setupWith(viewModel: CharacterViewModel) {
        nameLabel.text = viewModel.name
        cultureLabel.text = viewModel.culture
        bornLabel.text = viewModel.born
        diedLabel.text = viewModel.died
        seasonLabel.text = viewModel.seasons
    }
}
