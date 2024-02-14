//
//  BaseViewController.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import UIKit


class BaseViewController: UIViewController
{
    let baseViewModel: BaseViewModelProtocol = BaseViewModel()
    
    var locationLabel = UILabel()
    var currentTempLabel = UILabel()
    
    var forecastDaysTableView = UITableView()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.baseViewModel.fetchCurrentTemp()
        self.baseViewModel.fetchForecastDays()
        
        self.create_uiComponents()
        self.bind_elements()
    }
    

    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.setup_view()
    }
    
    
    
    func dayName(from dateString: String) -> String? 
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString)
        {
            let calendar = Calendar.current
            
            if calendar.isDateInToday(date) { return "Today" }
            else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
            else {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "EEEE"
                return dayFormatter.string(from: date)
            }
        } else {
            return nil
        }
    }
}



// for binding elements
extension BaseViewController
{
    func bind_elements()
    {
        self.bind_location()
        self.bind_currentTemp()
        self.bind_forecastDays()
    }
    
    
    
    func bind_location()
    {
        self.baseViewModel.location.bind { [weak self] location in
            guard let safeSelf = self,
                  let safeLocation = location else { return }
            
            safeSelf.locationLabel.text = safeLocation
        }
    }
    
    
    
    func bind_currentTemp()
    {
        self.baseViewModel.currentTemp.bind { [weak self] currentTemp in
            guard let safeSelf = self,
                  let safeCurrentTemp = currentTemp else { return }
            
            safeSelf.currentTempLabel.text = "\(safeCurrentTemp)°C"
        }
    }
    
    
    
    func bind_forecastDays()
    {
        self.baseViewModel.forecastResponse.bind { [weak self] forecastDays in
            guard let safeSelf = self,
                  let _ = forecastDays else { return }
            
            safeSelf.forecastDaysTableView.reloadData()
        }
    }
}



extension BaseViewController: UITableViewDelegate, UITableViewDataSource
{
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return self.baseViewModel.getForecastDaysCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastSingleDayCell", for: indexPath)
        
        if let safeDay = self.baseViewModel.getForecastDayFor(index: indexPath.row),
           let safeDayName = safeDay.date.dayName()
        {
            cell.textLabel?.text = safeDayName + ":   \(safeDay.day.mintemp_c)°C / \(safeDay.day.maxtemp_c)°C"
        }
        
        return cell
    }
    
    
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if let safeSingleDay = self.baseViewModel.getForecastDayFor(index: indexPath.row)
        {
            let vc = SingleDayViewController()
            vc.configuration(singleDay: safeSingleDay)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
