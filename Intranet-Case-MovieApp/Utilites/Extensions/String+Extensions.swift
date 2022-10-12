//
//  String+Extensions.swift
//  Intranet-Case-MovieApp
//
//  Created by Gizem Duman on 11.10.2022.
//

import Foundation

extension String {
    
    var intranetURL: URL? {
        let stringUrl = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        if let stringUrl = stringUrl {
            return URL(string: stringUrl)
        } else {
            return nil
        }
    }
}
