//
//  CharacterViewModelTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class CharacterViewModelTests: XCTestCase {
    var characterViewModel: CharacterViewModel!
    var characters: [Character]!
    
    override func setUpWithError() throws {
        let networkServiceLocal = NetworkServiceLocal(json: charactersJson)
        let localDataFetcher = NetworkDataFetcher(networkingService: networkServiceLocal)
        let charactersViewModel = CharactersViewModel(dataFetcher: localDataFetcher)

        charactersViewModel.fetchCharacters(completion: { response in
            switch response {
            case let .success(characters):
                self.characters = characters
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }

    override func tearDownWithError() throws {
        characterViewModel = nil
        characters = nil
    }
    
    func testFirstItemSeasonConverter() throws {
        guard let firstCharacter = characters.first else {
            XCTFail()
            return
        }

        characterViewModel = CharacterViewModel(character: firstCharacter)
        XCTAssertEqual(characterViewModel.seasons, "")
    }
    
    func testSecondItemInCharacters() throws {
        characterViewModel = CharacterViewModel(character: characters[1])
        XCTAssertEqual(characterViewModel.seasons, "I-IV, VI")
    }
    
    func testSeasonConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 3"]
        let expected = "I-III"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }

    func test6SeasonConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 3", "Season 4", "Season 5", "Season 6"]
        let expected = "I-VI"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func testEmptySeasonConverter() throws {
        let seasons = [""]
        let expected = ""
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func testWrongSeasonConverter() throws {
        let seasons = ["Season 22222"]
        let expected = ""
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func testAllSeasonsSeasonConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 3", "Season 4", "Season 5", "Season 6", "Season 7", "Season 8"]
        let expected = "I-VIII"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func testNineSeasonsSeasonConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 3", "Season 4", "Season 5", "Season 6", "Season 7", "Season 8", "Season 9"]
        let expected = "I-VIII"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func test4SeasonsAndOneConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 3", "Season 4","Season 6"]
        let expected = "I-IV, VI"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func testSeasons2BocksConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 3", "Season 5","Season 6"]
        let expected = "I-III, V-VI"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }
    
    func testSeasons3BocksConverter() throws {
        let seasons = ["Season 1", "Season 2", "Season 4", "Season 5","Season 7", "Season 8"]
        let expected = "I-II, IV-V, VII-VIII"
        characterViewModel = CharacterViewModel(character: characters[0])
        let result = characterViewModel.filtering(seasons: seasons)
        XCTAssertEqual(result, expected)
    }

}
