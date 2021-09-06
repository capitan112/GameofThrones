//
//  BooksViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import Foundation

protocol BooksViewModelType {
    var books: Bindable<[Book]?> { get }
    func fetchBooks(fetchCompletion: (() -> Void)?, errorCompletion: (() -> Void)?)
}

extension BooksViewModelType {
    func fetchBooks(fetchCompletion: (() -> Void)? = nil, errorCompletion: (() -> Void)? = nil) {
        return fetchBooks(fetchCompletion: fetchCompletion, errorCompletion: errorCompletion)
    }
}

class BooksViewModel: BooksViewModelType {
    typealias Completion = () -> Void
    private(set) var dataFetcher: NetworkDataFetcherProtocol!
    private(set) var books: Bindable<[Book]?> = Bindable(nil)

    init(dataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }

    func fetchBooks(fetchCompletion: Completion? = nil, errorCompletion: Completion? = nil) {
        dataFetcher.fetchBooks(completion: { response in
            switch response {
            case let .success(books):
                self.books.value = books
                if let fetchCompletion = fetchCompletion {
                    fetchCompletion()
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
                if let errorCompletion = errorCompletion {
                    errorCompletion()
                }
            }
        })
    }
}
