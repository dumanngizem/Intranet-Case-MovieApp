//
//  Movies.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation

struct Movie: Decodable {
    
    let search: [Search]?
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
