//
//  HomeViewController.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModelContracts = HomeViewModel(repository: MoviesRepository(moviesServices: MoviesServices()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        viewModel.viewDidLoad()
    }
}


// MARK: - ConfigureContents
extension HomeViewController {
    
    private func configureContents() {
        configureViewModel()
        configureHeaderContainerView()
        configureSearchBar()
        configureTableView()
    }

    private func configureViewModel() {
        viewModel.routes = self
        viewModel.output = self
    }
    
    private func configureHeaderContainerView() {
        headerContainerView.clipsToBounds = true
        headerContainerView.layer.cornerRadius = 32
        headerContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func configureSearchBar() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = .white.withAlphaComponent(0.7)
        searchBar.barTintColor = .clear
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.backgroundColor = UIColor.clear
        searchBar.delegate = self
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellId)
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellId, for: indexPath) as! MovieTableViewCell
        if let item = viewModel.searchMovieData?[indexPath.row] {
            cell.configureCell(title: item.title, year: item.year, imageUrl: item.poster?.intranetURL, type: item.type)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.height
        return height * 0.50
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchBarTextDidEndEditing(search: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - HomeViewModelOutput
extension HomeViewController: HomeViewModelOutput {
    func showEmptyData(isShow: Bool) {
        if isShow {
            self.tableView.showEmptyView(message: "Gösterilecek Bir Sonuç Bulunamadı")
        } else {
            self.tableView.restore()
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showLoadingIndicator(isShow: Bool) {
        if isShow {
            tableView.showActivityIndicator()
        } else {
            tableView.restore()
        }
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

// MARK: - HomeViewModelRoute
extension HomeViewController: HomeViewModelRoute {
    func presentMovieDetail(imdbID: String?) {
        let vc = MovieDetailBuilder.make()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
