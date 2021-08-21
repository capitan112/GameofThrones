//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import Foundation

protocol CharactersViewModelType {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
    func filtering(characters: [Character], target: String) -> [Character]
}

class CharactersViewModel: RootViewModel, CharactersViewModelType {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        dataFetcher.fetchCharacters(completion: completion)
    }

    func filtering(characters: [Character], target: String) -> [Character] {
        if target.isEmpty {
            return characters
        }

        let filteredCharacters = characters.filter { (character: Character) -> Bool in
            character.name.lowercased().range(of: target, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        return filteredCharacters
    }
}
