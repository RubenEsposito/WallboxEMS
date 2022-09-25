//
//  GenericService.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation
import Combine

enum GenericServiceResponseState<T: Codable> {
    case unknown
    case awaiting
    case success(_ value: T)
    case error(_ error: WallboxError)
}

enum WallboxError: Error {
    case unknown
    case decodingError
    case badURL
    case invalidStatusCode
    
    var localizedDescription: String {
        switch self {
        case .unknown: return "Something went wrong, please try again"
        case .decodingError: return "Could not decode the response"
        case .badURL: return "Wrong URL"
        case .invalidStatusCode: return "Invalid status code received from server"
        }
    }
}

protocol GenericService {
    var shared: URLSession { get }
    var decoder: JSONDecoder { get }
    
    func fetch<T: Codable>(request: URLRequest) -> AnyPublisher<T, Error>
}

extension GenericService {
    func fetch<T: Codable>(request: URLRequest) -> AnyPublisher<T, Error> {
        let publisher = shared.dataTaskPublisher(for:request)
            .retry(1)
            .tryMap({ output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw WallboxError.unknown
                }
                switch httpResponse.statusCode {
                case 200:
                    return output.data
                default:
                    throw WallboxError.invalidStatusCode
                }
            })
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
        return publisher
    }
}
