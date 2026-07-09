//
//  NetworkService.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case decoding
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let urlRequest = endpoint.makeRequest() else {
            throw NetworkError.invalidRequest
        }
        let (data, response) = try await self.session.data(for: urlRequest)
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }
        do {
            return try self.decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding
        }
    }
}
