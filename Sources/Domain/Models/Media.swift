//
//  Media.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

struct Media: Decodable, Equatable, Hashable {
    let url: String
    let isCover: Bool
}

extension Media
{
    var fullURL: URL? {
        URL(string: self.url, relativeTo: AppConfig.baseURL)
    }
}
