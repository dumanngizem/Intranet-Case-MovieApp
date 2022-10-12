//
//  TableView+Extensions.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func showEmptyView(message: String) {
        let view = EmptyCellView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
        view.text = message
        self.backgroundView = view
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        backgroundView = activityIndicator
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
