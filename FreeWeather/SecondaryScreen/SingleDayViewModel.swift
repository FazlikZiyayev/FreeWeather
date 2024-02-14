//
//  SingleDayViewModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 14/02/24.
//

import Foundation

class SingleDayViewModel
{
    var singleDay: Observable<ForecastDay?> = Observable(nil)
    
    
    func setSingleDay(singleDay: ForecastDay)
    {
        self.singleDay.value = singleDay
    }
    
    
    
    func getSingleDay() -> ForecastDay?
    {
        return self.singleDay.value ?? nil
    }
}
