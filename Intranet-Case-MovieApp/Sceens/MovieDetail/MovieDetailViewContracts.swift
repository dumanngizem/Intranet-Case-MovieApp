//
//  MovieDetailViewContracts.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import Foundation

// MARK: - Contratcs
protocol MovieDetailViewModelContracts {
    var routes: MovieDetailViewModelRoutes? { get set }
    var output: MovieDetailViewModelOutput? { get set }
    var repository: MoviesRepositoryConracts? { get set }
}

// MARK: - Routes
protocol MovieDetailViewModelRoutes: AnyObject {
    
}

// MARK: - Outputs
protocol MovieDetailViewModelOutput: AnyObject {
    
}
