//
//  BlackSearchBar.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import UIKit

class BlackSearchBar: UISearchBar {
    override func draw(_: CGRect) {
        customize()
    }

    private func customize() {
        barStyle = .black
        if let textfield = value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(red: 0.23, green: 0.22, blue: 0.23, alpha: 1.00)
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.lightGray
            }
        }
    }
}
