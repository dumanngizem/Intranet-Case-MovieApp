//
//  MovieTableViewCell.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    static let cellId: String = "MovieTableViewCell"

    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureContents()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureCell(title: String?, year: String?, imageUrl: URL?, type: String?) {
        guard let title = title, let year = year, let imageUrl = imageUrl, let type = type else {
            return
        }
        self.titleLabel.text = title
        self.descriptionLabel.text = year
        self.movieImage.kf.setImage(with: imageUrl)
        self.typeLabel.text = type
    }
}

// MARK: -
extension MovieTableViewCell {
    
    private func configureContents() {
        configureRatingView()
        configureContentView()
    }
    
    private func configureRatingView() {
        ratingView.layer.cornerRadius = 12
    }
    
    private func configureContentView() {
        selectionStyle = .none
    }

}
