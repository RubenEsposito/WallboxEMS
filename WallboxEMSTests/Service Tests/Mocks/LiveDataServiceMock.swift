//
//  LiveDataServiceMock.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation
import Combine
@testable import WallboxEMS

class LiveDataServiceMockUp: GenericService, LiveDataServiceProtocol {
    
    var shared: URLSession = URLSession(configuration: .default)
    var decoder: JSONDecoder = JSONDecoder()
    private let fileName = "live_data"
    
    func fetchLive<T: Codable>() -> AnyPublisher<T, Error> {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return Fail(error: WallboxError.badURL)
                .eraseToAnyPublisher()
        }
        do {
            let response = try Data(contentsOf: url)
            let live = try decoder.decode(T.self, from: response)
            return CurrentValueSubject<T, Error>(live)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: WallboxError.decodingError)
                .eraseToAnyPublisher()
        }
    }
}
