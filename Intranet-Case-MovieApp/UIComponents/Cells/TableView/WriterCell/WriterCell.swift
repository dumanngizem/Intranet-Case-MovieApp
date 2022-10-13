//
//  WriterCell.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import UIKit

class WriterCell: UITableViewCell {
    static let cellId = "WriterCell"

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureContents()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var data: [String]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - ConfigureContents
extension WriterCell {
    
    private func configureContents() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "WriterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: WriterCollectionViewCell.cellId)
    }
}

// MARK: - UICollectionViewDelegate
extension WriterCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension WriterCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WriterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WriterCollectionViewCell.cellId, for: indexPath) as! WriterCollectionViewCell
        if let data = data?[indexPath.row] {
            cell.configureCell(title: data)
        }
        return cell
    }
}

// MARK: -
extension WriterCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width * 0.30
        let height = bounds.height - 16
        return .init(width: width, height: height)
    }
}
