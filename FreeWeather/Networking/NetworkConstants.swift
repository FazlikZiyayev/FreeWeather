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
            return "015832e5c6df4045b3c124359241302"
        }
    }
    
    public var serverEndpoint: String
    {
        get {
            return "http://api.weatherapi.com/v1"
        }
    }
    
    
    private init()
    { 
        
    }
}
