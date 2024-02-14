//
//  NetworkManager.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation
import Alamofire


enum APIError: Error 
{
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}



protocol APIManagerProtocol 
{
    func fetchDataViaURLSession(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void)
    func fetchDataViaAlamofire(from url: URL, headers: HTTPHeaders?, completion: @escaping (Result<Data, APIError>) -> Void)
}



class APIManager: APIManagerProtocol
{
    func fetchDataViaURLSession(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void) 
    {
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
    
    
    
    func fetchDataViaAlamofire(from url: URL, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, APIError>) -> Void)
    {
        AF.request(url, headers: headers).validate(statusCode: 200..<299).responseData { response in
            if let error = response.error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response.response, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = response.data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // MARK: Saving successfull responses into cache memory
            if let safeResponse = response.response,
               let safeRequest = response.request
            {
                let cachedResponse = CachedURLResponse(response: safeResponse, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: safeRequest)
            }
            
            completion(.success(data))
        }
    }
}
