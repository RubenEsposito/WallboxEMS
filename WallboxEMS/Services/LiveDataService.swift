//
//  LiveDataService.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation
import Combine

protocol LiveDataServiceProtocol {
    func fetchLive<T: Codable>() -> AnyPublisher<T, Error>
}

class LiveDataService: GenericService, LiveDataServiceProtocol {
    var shared: URLSession = URLSession(configuration: .default)
    var decoder: JSONDecoder = JSONDecoder()
    private let serviceName = "live_data"
    
    func fetchLive<T: Codable>() -> AnyPublisher<T, Error> {
        guard let url = Bundle.main.url(forResource: serviceName, withExtension: "json") else {
            return Fail(error: WallboxError.badURL).eraseToAnyPublisher()
        }
        return fetch(request: URLRequest(url: url))
    }
}
