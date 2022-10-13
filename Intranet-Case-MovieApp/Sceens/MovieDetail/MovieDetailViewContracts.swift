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
    
    func viewDidLoad()
    func cellForItemAt() -> [String]?
    func imdbRating() -> Int?
    func cellForRowAt() -> MovieMetaData?
}

// MARK: - Routes
protocol MovieDetailViewModelRoutes: AnyObject {
    
}

// MARK: - Outputs
protocol MovieDetailViewModelOutput: AnyObject {
    func showError(message: String)
    func notifyResponse(data: MovieMetaData?)
    func reloadData()
}
