//
//  String-Extension.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 14/02/24.
//

import Foundation

extension String
{
    func dayName() -> String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self)
        {
            let calendar = Calendar.current
            
            if calendar.isDateInToday(date) { return "Today" }
            else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
            else {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "EEEE"
                return dayFormatter.string(from: date)
            }
        } 
        else
        {
            return nil
        }
    }
    
    
    
    func onlyHours() -> String? 
    {
        let inputFormat = "yyyy-MM-dd HH:mm"
        let outputFormat = "HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) 
        {
            dateFormatter.dateFormat = outputFormat
            let outputString = dateFormatter.string(from: date)
            
            return outputString
        } 
        else
        {
            return nil
        }
    }
}
