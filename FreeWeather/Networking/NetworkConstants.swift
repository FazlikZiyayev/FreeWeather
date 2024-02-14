//
//  NetworkConstants.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation

class NetworkConstants
{
    static let shared = NetworkConstants()
    
    public var apiKey: String
    {
        get {
            return ""
        }
    }
    
    public var serverEndpoint: String
    {
        get {
            return "https://api.weatherapi.com/v1/"
        }
    }
    
    
    private init()
    { 
        
    }
}
