//
//  RootUIViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import UIKit

class RootViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func reload(tableView: UITableView) {
        performUIUpdatesOnMain {
            tableView.reloadData()
        }
    }
    
    // MARK: UIActivityIndicatorView methods
    
    private func activityIndicator(style: UIActivityIndicatorView.Style = .large,
                                       frame: CGRect? = nil,
                                       center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.color = .white
        
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        
        if let center = center {
            activityIndicatorView.center = center
        }
        
        return activityIndicatorView
    }
    
    func addActivityIndicator(style: UIActivityIndicatorView.Style = .large,
                              frame: CGRect? = nil,
                              center: CGPoint? = nil) {
        let indicatorView = self.activityIndicator(style: style,
                                                  center: center)
        self.view.addSubview(indicatorView)
        self.activityIndicator = indicatorView
    }
    
    func startActivityIndicator() {
        performUIUpdatesOnMain {
            self.activityIndicator?.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        performUIUpdatesOnMain {
            self.activityIndicator?.stopAnimating()
        }
    }
}
