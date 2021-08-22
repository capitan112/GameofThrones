//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class BooksViewController: RootViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    private var viewModel: BooksViewModelType = BooksViewModel()
    var cachedBooks: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator(center: self.view.center)
        getBooks()
    }

    private func getBooks() {
        startActivityIndicator()
        viewModel.fetchBooks(completion: { response in
            switch response {
            case let .success(books):
                self.loadData(books: books)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        })
    }

    func loadData(books: [Book]) {
        cachedBooks = books
        reload(tableView: tableView)
        stopActivityIndicator()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cachedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.reuseIdentifierCell) as! BooksTableViewCell
        cell.setupWith(bookViewModel: BookViewModel(book: cachedBooks[indexPath.row]))

        return cell
    }
}

class BooksTableViewCell: UITableViewCell {
    static let reuseIdentifierCell = "BooksTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pagesLabel: UILabel!

    override func prepareForReuse() {
        titleLabel.text = ""
        dateLabel.text = ""
        pagesLabel.text = ""
    }
    
    func setupWith(bookViewModel: BookViewModel) {
        titleLabel.text = bookViewModel.name
        dateLabel.text = bookViewModel.released
        pagesLabel.text = bookViewModel.numberOfPages
    }
}
