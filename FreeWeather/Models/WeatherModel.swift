//
//  WeatherModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation


struct WeatherResponse: Codable
{
    let location: Location
    let current: Current
}


struct Location: Codable 
{
    let name: String
    let region: String
}

struct Current: Codable 
{
    let temp_c: Double
}

