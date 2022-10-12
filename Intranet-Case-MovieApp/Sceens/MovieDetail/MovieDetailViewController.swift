//
//  MovieDetailViewController.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 12.10.2022.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    public var viewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - MovieDetailViewModelOutput
extension MovieDetailViewController: MovieDetailViewModelOutput {
    
}

// MARK: - Routes
extension MovieDetailViewController: MovieDetailViewModelRoutes {
    
}
