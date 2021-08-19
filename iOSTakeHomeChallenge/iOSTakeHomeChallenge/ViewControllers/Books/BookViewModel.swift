//
//  BookViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import Foundation

class BookViewModel {
    private(set) var name: String
    private(set) var released: String
    private(set) var numberOfPages: String

    init(book: Book) {
        self.name = book.name
        self.released = DateFormatter.monthYearFormatter.string(from: book.released)
        self.numberOfPages = String(book.numberOfPages) + " " + "pages"
    }
}
