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
        if let absoluteURL = URL(string: self.url), absoluteURL.scheme != nil {
            return absoluteURL
        }

        let normalizedPath: String
        if self.url.hasPrefix("/api/") {
            normalizedPath = self.url
        } else if self.url.hasPrefix("/") {
            normalizedPath = "/api" + self.url
        } else {
            normalizedPath = "/api/" + self.url
        }

        return URL(string: normalizedPath, relativeTo: AppConfig.baseURL)
    }
}
