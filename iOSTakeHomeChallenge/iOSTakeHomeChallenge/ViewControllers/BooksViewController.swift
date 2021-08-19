//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class BooksViewController: RootViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    private var viewModel: BooksViewModelType = BooksViewModel()
    
    var cachedBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }
      
    func getBooks() {
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(bookViewModel: BookViewModel(book: cachedBooks[indexPath.row]))
        
        return cell
    }
    
}

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    func setupWith(bookViewModel: BookViewModel) {
        titleLabel.text = bookViewModel.name
        dateLabel.text = bookViewModel.released
        pagesLabel.text =  bookViewModel.numberOfPages
    }
}
