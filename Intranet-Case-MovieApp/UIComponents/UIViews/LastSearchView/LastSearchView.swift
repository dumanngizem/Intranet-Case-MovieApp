//
//  LastSearchView.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 13.10.2022.
//

import UIKit

class LastSearchView: UIView {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        configureContents()
    }
    
    public var data: [SearchLocal]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    public weak var delegate: TextAndCloseCellDelegate?
}

// MARK: - UILayout
extension LastSearchView {
 
    private func addSubViews() {
        addTableView()
    }
    
    private func addTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - ConfigureContents
extension LastSearchView {
    
    private func configureContents() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TextAndCloseCell", bundle: nil), forCellReuseIdentifier: TextAndCloseCell.cellId)
    }
}

// MARK: - UITableViewDelegate
extension LastSearchView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension LastSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TextAndCloseCell = tableView.dequeueReusableCell(withIdentifier: TextAndCloseCell.cellId, for: indexPath) as! TextAndCloseCell
        cell.delegate = delegate
        if let data = data?[indexPath.row] {
            cell.setTitle = data.texts
        }
        return cell
    }
}
