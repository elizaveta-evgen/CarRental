//
//  Endpoint.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]

    init(path: String, method: HTTPMethod = .get, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
}

extension Endpoint
{
    func makeRequest() -> URLRequest? {
        guard var components = URLComponents(url: AppConfig.baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.path = self.path
        if !self.queryItems.isEmpty {
            components.queryItems = self.queryItems
        }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        return request
    }
}
