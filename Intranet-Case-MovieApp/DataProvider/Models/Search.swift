//
//  Search.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation

struct Search: Decodable {
    let title, year, imdbID: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
