//
//  SingleDayViewModel.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 14/02/24.
//

import Foundation



protocol SingleDayViewModelProtocol
{
    var singleDay: Observable<ForecastDay?> { get set }
    
    func setSingleDay(singleDay: ForecastDay)
    func getSingleDay() -> ForecastDay?
}



final class SingleDayViewModel: SingleDayViewModelProtocol
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
