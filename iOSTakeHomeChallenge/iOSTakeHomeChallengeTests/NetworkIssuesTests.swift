//
//  NetworkIssuesTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Oleksiy Chebotarov on 02/09/2021.
//

@testable import iOSTakeHomeChallenge
import XCTest

class NetworkIssuesTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testFetchResponseErrorWithNoJSON() throws {
        let networkServiceLocal = NetworkServiceLocal(json: "")
        let localDataFetcher = NetworkDataFetcher(networkingService: networkServiceLocal)
        let booksViewModel = BooksViewModel(dataFetcher: localDataFetcher)

        booksViewModel.fetchBooks(completion: { response in
            switch response {
            case .success:
                XCTFail()
            case let .failure(error):
                XCTAssertEqual(ConversionFailure.jsonDecondingError, error as! ConversionFailure)
            }
        })
    }

    func testFetchResponseWithBadURL() throws {
        let networkService = NetworkService()
        networkService.request(path: "", completion: { response in
            switch response {
            case .success:
                XCTFail()
            case let .failure(error):
                XCTAssertEqual(ConversionFailure.badURL, error as! ConversionFailure)
            }
        })
    }
}
