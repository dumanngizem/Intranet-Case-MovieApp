//
//  StackView+Extensions.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import UIKit

extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}
