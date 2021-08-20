//
//  CharactersViewModelTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class CharactersViewModelTests: XCTestCase {

    var characterViewModel: CharacterViewModel!
    var charactersViewModel: CharactersViewModelType!
    var characters: [Character]!
    
    override func setUpWithError() throws {
        let networkServiceLocal = NetworkServiceLocal(json: charactersJson)
        let localDataFetcher = NetworkDataFetcher(networkingService: networkServiceLocal)
        charactersViewModel = CharactersViewModel(dataFetcher: localDataFetcher)

        charactersViewModel.fetchCharacters(completion: { response in
            switch response {
            case let .success(characters):
//                performUIUpdatesOnMain {
                    self.characters = characters
//                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }

    override func tearDownWithError() throws {
        characterViewModel = nil
        charactersViewModel = nil
        characters = nil
    }

    func testFetchResponseContainsValues() throws {
        charactersViewModel.fetchCharacters(completion: { response in
            switch response {
            case let .success(characters):
                XCTAssertTrue(characters.count > 0)
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }

    func testFirstItemInCharacters() throws {
        guard let firstCharacter = characters.first else {
            XCTFail()
            return
        }
          
        characterViewModel = CharacterViewModel(character: firstCharacter)
        XCTAssertEqual(characterViewModel.name, "")
        XCTAssertEqual(characterViewModel.culture, "Braavosi")
        XCTAssertEqual(characterViewModel.born, "")
        XCTAssertEqual(characterViewModel.died, "")
        XCTAssertEqual(characterViewModel.seasons, "")
    }

    func testSecondItemInCharacters() throws {
        characterViewModel = CharacterViewModel(character: characters[1])
        XCTAssertEqual(characterViewModel.name, "Walder")
        XCTAssertEqual(characterViewModel.culture, "")
        XCTAssertEqual(characterViewModel.born, "")
        XCTAssertEqual(characterViewModel.died, "")
        XCTAssertEqual(characterViewModel.seasons, "I, II, III, IV, VI")
    }

}
