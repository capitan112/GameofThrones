//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import Foundation

protocol CharactersViewModelType {
    var cachedCharacters: [Character] { get }
    var filteredCharacters: [Character] { get }
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
    func filtering(with target: String)
    func setUp(characters: [Character])
    func discardSearching()
}

class CharactersViewModel: RootViewModel, CharactersViewModelType {
    private(set) var cachedCharacters: [Character] = []
    private(set) var filteredCharacters: [Character] = []
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        dataFetcher.fetchCharacters(completion: completion)
    }

    func setUp(characters: [Character]) {
        cachedCharacters = characters
        filteredCharacters = cachedCharacters
    }

    func discardSearching() {
        filteredCharacters = cachedCharacters
    }

    func filtering(with target: String) {
        if target.isEmpty {
            discardSearching()
            return
        }

        filteredCharacters = cachedCharacters.filter { (character: Character) -> Bool in
            character.name.lowercased().range(of: target, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }
}
