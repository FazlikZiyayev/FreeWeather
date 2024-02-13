//
//  ForecastModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 14/02/24.
//

import Foundation


struct ForecastResponse: Codable {
    let forecast: Forecast
}


struct Forecast: Codable {
    let forecastday: [ForecastDay]
}


struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let avgtemp_c: Double
}


struct Hour: Codable {
    let time: String
    let temp_c: Double
}
