//
//  BaseViewModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation
import Reachability


protocol BaseViewModelProtocol
{
    var location: Observable<String> { get set }
    var currentTemp: Observable<String> { get set }
    
    var forecastResponse: Observable<ForecastResponse> { get set }
    
    func getReachabilityObj() -> Reachability?
    func getForecastDaysCount() -> Int
    func getForecastDayFor(index: Int) -> ForecastDay?
    
    func fetchCurrentTemp()
    func fetchForecastDays()
}



final class BaseViewModel: BaseViewModelProtocol
{
    private var apiManager: APIManagerProtocol = APIManager()
    let reachability = try? Reachability()

    
    var location: Observable<String> = Observable("--")
    var currentTemp: Observable<String> = Observable("-°C")
    
    var forecastResponse: Observable<ForecastResponse> = Observable(ForecastResponse(forecast: Forecast(forecastday: [])))
    
    
    func getReachabilityObj() -> Reachability?
    {
        return self.reachability
    }
    
    
    func getForecastDaysCount() -> Int
    {
        self.forecastResponse.value?.forecast.forecastday.count ?? 0
    }
    
    
    
    func getForecastDayFor(index: Int) -> ForecastDay?
    {
        return index > self.getForecastDaysCount() ? nil : self.forecastResponse.value?.forecast.forecastday[index]
    }
    
    
    
    func fetchCurrentTemp()
    {
        let apiKey = NetworkConstants.shared.apiKey
        let baseUrl = NetworkConstants.shared.serverEndpoint
        
        guard let safeUrl = URL(string: baseUrl + "current.json?key=" + apiKey + "&q=Uzbekistan") else { return }
        let request = URLRequest(url: safeUrl)
        
        
        if let connection = reachability?.connection, connection == .unavailable
        {
            if let cachedResponse = URLCache.shared.cachedResponse(for: request) 
            {
                do {
                    let result = try JSONDecoder().decode(WeatherResponse.self, from: cachedResponse.data)
                    self.location.value = result.location.name
                    self.currentTemp.value = "\(Int(result.current.temp_c))"
                    
                } catch {
                    print(error)
                }
            }
        } else {
            self.fetchCurrentTemp_fromNework(url: safeUrl)
        }
    }
    
    
    
    private func fetchCurrentTemp_fromNework(url: URL)
    {
        self.apiManager.fetchDataViaAlamofire(from: url, headers: nil)
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
        let request = URLRequest(url: safeUrl)

        
        if let connection = reachability?.connection, connection == .unavailable
        {
            if let cachedResponse = URLCache.shared.cachedResponse(for: request)
            {
                do {
                    let result = try JSONDecoder().decode(ForecastResponse.self, from: cachedResponse.data)
                    self.forecastResponse.value = result
                } catch {
                    print(error)
                }
            }
        } else {
            self.fetchForecastDays_fromNetwork(url: safeUrl)
        }
    }
    
    
    
    private func fetchForecastDays_fromNetwork(url: URL)
    {
        self.apiManager.fetchDataViaAlamofire(from: url, headers: nil)
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
