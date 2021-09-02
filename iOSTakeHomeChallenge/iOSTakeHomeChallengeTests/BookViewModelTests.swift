//
//  iOSTakeHomeChallengeTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Oleksiy Chebotarov on 19/08/2021.
//

@testable import iOSTakeHomeChallenge
import XCTest

class iOSTakeHomeChallengeTests: XCTestCase {
    var bookViewModel: BookViewModel!
    var booksViewModel: BooksViewModelType!
    var books: [Book]!

    override func setUpWithError() throws {
        let networkServiceLocal = NetworkServiceLocal(json: booksJson)
        let localDataFetcher = NetworkDataFetcher(networkingService: networkServiceLocal)
        booksViewModel = BooksViewModel(dataFetcher: localDataFetcher)

        booksViewModel.fetchBooks(completion: { response in
            switch response {
            case let .success(books):
                self.books = books
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }

    override func tearDownWithError() throws {
        booksViewModel = nil
        bookViewModel = nil
        books = nil
    }

    func testFetchResponseContainsValues() throws {
        booksViewModel.fetchBooks(completion: { response in
            switch response {
            case let .success(books):
                XCTAssertTrue(books.count > 0)
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }

    func testFirstItemInBooks() throws {
        bookViewModel = BookViewModel(book: books[0])
        XCTAssertEqual(bookViewModel.name, "A Game of Thrones")
        XCTAssertEqual(bookViewModel.released, "Aug 1996")
        XCTAssertEqual(bookViewModel.numberOfPages, "694 pages")
    }

    func testSecondItemInBooks() throws {
        bookViewModel = BookViewModel(book: books[1])
        XCTAssertEqual(bookViewModel.name, "A Clash of Kings")
        XCTAssertEqual(bookViewModel.released, "Feb 1999")
        XCTAssertEqual(bookViewModel.numberOfPages, "768 pages")
    }
}
