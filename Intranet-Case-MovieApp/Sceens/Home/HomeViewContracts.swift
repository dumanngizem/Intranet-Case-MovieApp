//
//  HomeViewContracts.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation

//MARK: - Contracts
protocol HomeViewModelContracts {
    var routes: HomeViewModelRoute? { get set }
    var output: HomeViewModelOutput? { get set }
    var repository: MoviesRepositoryConracts { get set }
    var searchMovieData: [Search]? { get set }
    var isShowLastSearch: Bool { get set }
    
    var numberOfRowsInSection: Int { get }
    
    func viewDidLoad()
    func searchBarTextDidEndEditing(search: String?)
    func didSelectRowAt(indexPath: IndexPath)
    func closeButtonTapped(string: String?)
}

// MARK: - Routes
protocol HomeViewModelRoute: AnyObject {
    func presentMovieDetail(imdbID: String?)
}

//MARK: - Outputs
protocol HomeViewModelOutput: AnyObject {
    func showLastSearch(data: [SearchLocal])
    func showError(message: String)
    func showLoadingIndicator(isShow: Bool)
    func showEmptyData(isShow: Bool)
    func reloadData()
}
