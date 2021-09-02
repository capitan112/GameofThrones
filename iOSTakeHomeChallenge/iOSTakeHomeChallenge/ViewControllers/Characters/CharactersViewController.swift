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

    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator(center: view.center)
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
                self.showAlertAndStopActivityIndicator()
            }
        })
    }

    func loadData(characters: [Character]) {
        viewModel.setUp(characters: characters)
        reload(tableView: tableView)
        stopActivityIndicator()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.filteredCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(viewModel: CharacterViewModel(character: viewModel.filteredCharacters[indexPath.row]))

        return cell
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        viewModel.filtering(with: searchText)
        reload(tableView: tableView)
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        viewModel.discardSearching()
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
