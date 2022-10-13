//
//  WriterCollectionViewCell.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import UIKit

class WriterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var writerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    static let cellId = "WriterCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        configureContents()
    }
    
    public func configureCell(title: String?) {
        guard let title = title else {
            return
        }
        titleLabel.text = title
        writerImageView.image = UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysTemplate)
        writerImageView.tintColor = .gray
    }
}

// MARK: - ConfigureContents
extension WriterCollectionViewCell {
    
    private func configureContents() {
        writerImageView.layoutIfNeeded()
        writerImageView.layer.cornerRadius = writerImageView.frame.height / 2
    }
}
