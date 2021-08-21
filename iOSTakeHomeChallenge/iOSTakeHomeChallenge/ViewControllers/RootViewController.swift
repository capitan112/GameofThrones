//
//  RootUIViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import UIKit

class RootViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func reload(tableView: UITableView) {
        performUIUpdatesOnMain {
            tableView.reloadData()
        }
    }
}
