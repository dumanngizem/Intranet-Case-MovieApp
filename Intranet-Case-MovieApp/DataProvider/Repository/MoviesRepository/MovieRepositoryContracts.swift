//
//  MovieRepositoryContracts.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation

protocol MoviesRepositoryConracts {
    func getMovies(search: String, page: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void)
    func getMovieDetail(imdbId: String, completion: @escaping (Result<MovieMetaData, NetworkError>) -> Void)
}
