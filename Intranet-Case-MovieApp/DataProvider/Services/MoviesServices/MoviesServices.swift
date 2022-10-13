//
//  MoviesServices.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation

final class MoviesServices: MoviesDataSources {
    func getMovieDetail(imdbId: String, completion: @escaping (Result<MovieMetaData, NetworkError>) -> Void) {
        NetworkExecuter.shared.execute(route: TheOmdbAPIClients.getMovieDetail(imdbId: imdbId), responseModel: MovieMetaData.self, completion: completion)
    }
    
    func getMovies(search: String, page: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        NetworkExecuter.shared.execute(route: TheOmdbAPIClients.getMovies(search: search, page: page), responseModel: Movie.self, completion: completion)
    }
}
