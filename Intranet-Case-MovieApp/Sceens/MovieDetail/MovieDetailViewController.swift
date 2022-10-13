//
//  MovieDetailViewController.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import Foundation
import UIKit

enum MovieDetailViewControllerCellType: CaseIterable {
    case rating
    case information
    case writers
}

class MovieDetailViewController: UIViewController {
    
    public var viewModel: MovieDetailViewModel?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        configureContents()
    }
}

// MARK: -
extension MovieDetailViewController {
    
    private func configureContents() {
        configureViewModel()
        configureNavigationBar()
        configureMovieImageView()
        configureTableView()
    }
    
    private func configureViewModel() {
        viewModel?.routes = self
        viewModel?.output = self
    }
    
    private func configureNavigationBar() {
        let attributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        let appearance = UINavigationBarAppearance()
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = attributed
        appearance.backButtonAppearance = backButtonAppearance
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = attributed
        appearance.largeTitleTextAttributes = attributed
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let barButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = barButton
        
    }
    
    private func configureMovieImageView() {
        movieImageView.layer.cornerRadius = 32
        movieImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: RatingCell.cellId)
        tableView.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: InformationCell.cellId)
        tableView.register(UINib(nibName: "WriterCell", bundle: nil), forCellReuseIdentifier: WriterCell.cellId)
        tableView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

// MARK: - UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MovieDetailViewControllerCellType.allCases[indexPath.section] {
        case .rating:
            let cell: RatingCell = tableView.dequeueReusableCell(withIdentifier: RatingCell.cellId, for: indexPath) as! RatingCell
            if let index = viewModel?.imdbRating() {
                cell.currentIndex = index
            }
            return cell
        case .information:
            let cell: InformationCell = tableView.dequeueReusableCell(withIdentifier: InformationCell.cellId, for: indexPath) as! InformationCell
            if let item = viewModel?.cellForRowAt() {
                cell.configureCell(title: item.title, description: item.plot)
            }
            return cell
        case .writers:
            let cell: WriterCell = tableView.dequeueReusableCell(withIdentifier: WriterCell.cellId, for: indexPath) as! WriterCell
            if let data = viewModel?.cellForItemAt() {
                cell.data = data
            }
            return cell
        }
    }
}

// MARK: - Actions
extension MovieDetailViewController {

    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

// MARK: - MovieDetailViewModelOutput
extension MovieDetailViewController: MovieDetailViewModelOutput {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func notifyResponse(data: MovieMetaData?) {
        guard let data = data else { return }
        title = data.title
        movieImageView.kf.setImage(with: data.poster?.intranetURL)

    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Routes
extension MovieDetailViewController: MovieDetailViewModelRoutes {
    
}
