//
//  NetworkingManager.swift
//  Exchages
//
//  Created by Dario Gallegos on 19/10/22.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLReponse(url: String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLReponse(url: let url): return "Respuesta incorrecta de la URL: \(url)"
            case .unknown: return "Ha occurrido un error desconocido"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
       
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLReponse(url: url.absoluteString)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
