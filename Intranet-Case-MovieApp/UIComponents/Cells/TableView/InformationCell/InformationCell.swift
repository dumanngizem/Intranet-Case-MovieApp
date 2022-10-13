//
//  InformationCell.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import UIKit

class InformationCell: UITableViewCell {

    static let cellId = "InformationCell"
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    public func configureCell(title: String?, description: String?) {
        guard let title = title, let description = description else { return }
        titleLabel.text = title
        descLabel.text = description
    }
}
