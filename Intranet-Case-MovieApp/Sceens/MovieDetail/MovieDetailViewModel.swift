//
//  MovieDetailViewModel.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import Foundation

final class MovieDetailViewModel: MovieDetailViewModelContracts {
    
    var routes: MovieDetailViewModelRoutes?
    var output: MovieDetailViewModelOutput?
    var repository: MoviesRepositoryConracts?
    
    private var imbdbID: String?
    private var writers: [String]?
    private var data: MovieMetaData?
    
    init(imdbID: String?, repository: MoviesRepositoryConracts) {
        self.repository = repository
        self.imbdbID = imdbID
    }
    
    func viewDidLoad() {
        fetchMovieDetail()
    }
    
    func cellForItemAt() -> [String]? {
        return writers
    }
    
    func imdbRating() -> Int? {
        guard let data = data else { return 0 }
        let rateDouble = Double(data.imdbRating ?? "0")
        let intRating: Int = Int(rateDouble ?? 0)
        let halfRating = intRating / 2
        return halfRating
    }
    
    func cellForRowAt() -> MovieMetaData? {
        return data
    }
}

// MARK: - DataSources
extension MovieDetailViewModel {


}

// MARK: - ConfigureContents
extension MovieDetailViewModel {
    
    private func configureWriterCellItem(writers: String?) {
        guard let writers = writers else { return }
        let strings = writers.split(separator: ",")
        let stringsArray = strings.map({ String($0) })
        self.writers = stringsArray
        output?.reloadData()
    }
}

// MARK: - Requests
extension MovieDetailViewModel {
    
    private func fetchMovieDetail() {
        guard let id = imbdbID else { return }
        repository?.getMovieDetail(imdbId: id, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.data = response
                self?.configureWriterCellItem(writers: response.writer)
                self?.output?.notifyResponse(data: response)
            case .failure(let error):
                self?.output?.showError(message: error.localizedDescription)
            }
        })
    }
}
