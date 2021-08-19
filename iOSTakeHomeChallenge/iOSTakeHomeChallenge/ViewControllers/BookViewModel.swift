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
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()
    
    init(book: Book) {
        self.name = book.name
        let date: Date? = dateFormatter.date(from: book.released)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        self.released = ""
        if let date = date {
            self.released = formatter.string(from: date)
        }
        self.numberOfPages = String(book.numberOfPages) + " " + "pages"
    }
}
