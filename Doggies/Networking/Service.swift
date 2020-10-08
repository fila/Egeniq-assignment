//
//  DogService.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import Foundation
import RxSwift

protocol ServiceProtocol {
    func get() -> Single<[Dog]>
}

class Service: ServiceProtocol {
    
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    
    func get() -> Single<[Dog]> {
        
        return .create { [urlSession, decoder] observer in
            guard var urlComponents = URLComponents(string: "https://api.thedogapi.com/v1/images/search") else {
                observer(.error(DataError.wrongUrlFormat))
                return Disposables.create()
            }
            urlComponents.query = "size=small&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=10"
            guard let url = urlComponents.url else {
                observer(.error(DataError.wrongUrlFormat))
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.addValue("1a316891-14df-4945-b317-ad0e6c009e78", forHTTPHeaderField: "x-api-key")
            
            urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.error(DataError.fetchingDataFailed(error)))
                }
                
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        observer(.error(DataError.fetchingDataFailed(nil)))
                        return
                    }
                    do {
                        let result = try decoder.decode([Dog].self, from: data)
                        observer(.success(result))
                    } catch {
                        observer(.error(DataError.decodingDataFailed(error)))
                    }
            }.resume()
            return Disposables.create()
        }
    }
}
