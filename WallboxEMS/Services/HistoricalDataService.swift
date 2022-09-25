//
//  HistoricalDataService.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import Foundation
import Combine

protocol HistoricalDataServiceProtocol {
    func fetchHistorical<T: Codable>() -> AnyPublisher<[T], Error>
}

class HistoricalDataService: GenericService, HistoricalDataServiceProtocol {
    var shared: URLSession = URLSession(configuration: .default)
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    private let serviceName = "historic_data"
    
    func fetchHistorical<T: Codable>() -> AnyPublisher<[T], Error> {
        guard let url = Bundle.main.url(forResource: serviceName, withExtension: "json") else {
            return Fail(error: WallboxError.badURL).eraseToAnyPublisher()
        }
        return fetch(request: URLRequest(url: url))
    }
}
