//
//  RatingCell.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import UIKit

class RatingCell: UITableViewCell {
    
    static let cellId = "RatingCell"

    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public var currentIndex: Int = 0 {
        didSet {
            configureContents()
        }
    }
    
}

// MARK: -
extension RatingCell {
    
    private func configureContents() {
        self.stackView.removeFullyAllArrangedSubviews()
        for i in 0..<5 {
            let imageView = UIImageView()
            imageView.image = currentIndex > i ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            imageView.tintColor = .yellow
            self.stackView.addArrangedSubview(imageView)
        }
    }
}
