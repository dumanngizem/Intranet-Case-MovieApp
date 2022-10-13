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
    var isShowLastSearch: Bool = true
    private var lastTexts: [String] = []
    
    
    init(repository: MoviesRepositoryConracts) {
        self.repository = repository
    }
    
    func viewDidLoad() {
        fetchMovies(search: "Batman")
        fetchLastSearch()
        
    }
    
    func searchBarTextDidEndEditing(search: String?) {
        guard let text = search else { return }
        if !text.isEmpty {
            fetchMovies(search: text)
            lastTexts.append(text)
            let model = SearchLocal(context: CoreDataHelper.shared.context)
            model.texts = text
            model.timeStamp = Date.now
            CoreDataHelper.shared.addObject(entity: model)
            fetchLastSearch()
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let id = searchMovieData?[indexPath.row].imdbID
        routes?.presentMovieDetail(imdbID: id)
    }
    
    func closeButtonTapped(string: String?) {
        guard let text = string else { return }
        CoreDataHelper.shared.removeLastSearch(title: text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchLastSearch()
        }
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
    
    private func fetchLastSearch() {
        guard let item = CoreDataHelper.shared.getDatas(entity: SearchLocal.self) else { return }
        let filterData = item.prefix(5)
        let lastStringArray = Array(filterData)
        output?.showLastSearch(data: lastStringArray)
    }
}
