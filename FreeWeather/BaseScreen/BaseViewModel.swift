//
//  BaseViewModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation


class BaseViewModel
{
    var apiManager: APIManagerProtocol = APIManager()
    
    var location: Observable<String> = Observable("--")
    var currentTemp: Observable<String> = Observable("-°C")
    
    var forecastResponse: Observable<ForecastResponse?> = Observable(nil)
    
    
    
    func getCurrentTemp() -> String?
    {
        return self.currentTemp.value
    }
    
    
    
    func fetchCurrentTemp()
    {
        let apiKey = NetworkConstants.shared.apiKey
        let baseUrl = NetworkConstants.shared.serverEndpoint
        
        guard let safeUrl = URL(string: baseUrl + "current.json?key=" + apiKey + "&q=Uzbekistan") else { return }
        
        self.apiManager.fetchDataViaAlamofire(from: safeUrl, headers: nil)
        { [weak self] result in
            
            guard let self = self else { return }
            
            switch result
            {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    self.location.value = result.location.name
                    self.currentTemp.value = "\(Int(result.current.temp_c))"
                    
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    
    func fetchForecastDays()
    {
        let apiKey = NetworkConstants.shared.apiKey
        let baseUrl = NetworkConstants.shared.serverEndpoint
        
        guard let safeUrl = URL(string: baseUrl + "forecast.json?key=" + apiKey + "&q=Uzbekistan&days=10") else { return }
        
        self.apiManager.fetchDataViaAlamofire(from: safeUrl, headers: nil)
        { [weak self] result in
            
            guard let self = self else { return }
            
            switch result
            {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(ForecastResponse.self, from: data)
                    self.forecastResponse.value = result
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
