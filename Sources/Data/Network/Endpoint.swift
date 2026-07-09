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
    static let baseURL = URL(string: "https://PASTE_BACKEND_URL_HERE")!

    func makeRequest() -> URLRequest? {
        let fullURL = Self.baseURL.appendingPathComponent(self.path)
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        if !self.queryItems.isEmpty {
            components?.queryItems = self.queryItems
        }
        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        return request
    }
}
