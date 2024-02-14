//
//  BaseViewModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation


protocol BaseViewModelProtocol
{
    var location: Observable<String> { get set }
    var currentTemp: Observable<String> { get set }
    
    var forecastResponse: Observable<ForecastResponse> { get set }
    
    func getForecastDaysCount() -> Int
    func getForecastDayFor(index: Int) -> ForecastDay?
    
    func fetchCurrentTemp()
    func fetchForecastDays()
}



final class BaseViewModel: BaseViewModelProtocol
{
    private var apiManager: APIManagerProtocol = APIManager()
    
    var location: Observable<String> = Observable("--")
    var currentTemp: Observable<String> = Observable("-°C")
    
    var forecastResponse: Observable<ForecastResponse> = Observable(ForecastResponse(forecast: Forecast(forecastday: [])))
    
    
    
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
