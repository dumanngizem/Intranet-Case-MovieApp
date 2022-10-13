//
//  MovieDetailBuilder.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import Foundation
import UIKit

final class MovieDetailBuilder {
    
    static func make(id: String?) -> MovieDetailViewController {
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailViewController
        let services = MoviesServices()
        let repository = MoviesRepository(moviesServices: services)
        let viewModel = MovieDetailViewModel(imdbID: id, repository: repository)
        vc.viewModel = viewModel
        return vc
    }
}
