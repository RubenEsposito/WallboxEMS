//
//  HistoricalDataServiceMock.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation
import Combine

class HistoricalDataServiceMock: GenericService, HistoricalDataServiceProtocol {
    var urlSession: URLSession = URLSession(configuration: .default)
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    private let fileName = "historic_data"
    
    func fetchHistorical<T: Codable>() -> AnyPublisher<[T], Error> {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return Fail(error: WallboxError.badURL).eraseToAnyPublisher()
        }
        do {
            let response = try Data(contentsOf: url)
            let historical = try decoder.decode([T].self, from: response)
            return CurrentValueSubject<[T], Error>(historical)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: WallboxError.decodingError)
                .eraseToAnyPublisher()
        }
    }
}
