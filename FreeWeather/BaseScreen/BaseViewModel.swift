//
//  BaseViewModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import Foundation


class BaseViewModel
{
    var currentTemp: Observable<String> = Observable("0")
    
    
    
    func getCurrentTemp() -> String?
    {
        return self.currentTemp.value
    }
}
