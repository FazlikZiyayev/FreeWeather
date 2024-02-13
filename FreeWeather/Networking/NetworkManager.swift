//
//  NetworkManager.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation



enum APIError: Error 
{
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}



protocol APIManagerProtocol 
{
    func fetchData(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void)
}



class APIManager: APIManagerProtocol
{
    func fetchData(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
