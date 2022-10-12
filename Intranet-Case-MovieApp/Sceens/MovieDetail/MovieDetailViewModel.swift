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
    
    
    init(repository: MoviesRepositoryConracts) {
        self.repository = repository
    }
    
}

// MARK: - DataSources
extension MovieDetailViewModel {
    
}

// MARK: - ConfigureContents
extension MovieDetailViewModel {
    
}

// MARK: - Requests
extension MovieDetailViewModel {
    
}
