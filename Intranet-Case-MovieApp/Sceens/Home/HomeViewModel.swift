//
//  HomeViewModel.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation


final class HomeViewModel: HomeViewModelContracts {
    weak var routes: HomeViewModelRoute?
    weak var output: HomeViewModelOutput?
    var repository: MoviesRepositoryConracts
    
    var searchMovieData: [Search]?
    
    init(repository: MoviesRepositoryConracts) {
        self.repository = repository
    }
    
    func viewDidLoad() {
        fetchMovies(search: "Batman")
    }
    
    func searchBarTextDidEndEditing(search: String?) {
        guard let text = search else { return }
        if !text.isEmpty {
            fetchMovies(search: text)
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let id = searchMovieData?[indexPath.row].imdbID
        routes?.presentMovieDetail(imdbID: id)
    }
}

// MARK: - DataSources
extension HomeViewModel {
 
    var numberOfRowsInSection: Int {
        return searchMovieData?.count ?? 0
    }
}

// MARK: - ConfigureContents
extension HomeViewModel {
    
    private func configureMovieCell(searchData: [Search]?) {
        guard let searchData = searchData else {
            return
        }
        self.searchMovieData = searchData
    }
}


// MARK: - Requests
extension HomeViewModel {
    
    private func fetchMovies(search: String) {
        output?.showLoadingIndicator(isShow: true)
        self.repository.getMovies(search: search, page: 1) { [weak self] result in
            guard let self = self else { return }
            self.output?.showLoadingIndicator(isShow: false)
            switch result {
            case .success(let response):
                self.configureMovieCell(searchData: response.search)
                self.output?.reloadData()
                self.output?.showEmptyData(isShow: response.search?.isEmpty ?? true)
            case .failure(let error):
                self.output?.showError(message: error.localizedDescription)
            }
        }
    }
}
