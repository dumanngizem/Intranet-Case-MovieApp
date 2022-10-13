//
//  TextAndCloseCell.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 13.10.2022.
//

import UIKit

protocol TextAndCloseCellDelegate: AnyObject {
    func closeButtonTapped(string: String?)
}

final class TextAndCloseCell: UITableViewCell {

    static let cellId = "TextAndCloseCell"

    @IBOutlet weak var titleLabel: UILabel!
    public var delegate: TextAndCloseCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        delegate?.closeButtonTapped(string: setTitle)
    }
    
    public var setTitle: String? {
        didSet {
            titleLabel.text = setTitle
        }
    }
}
