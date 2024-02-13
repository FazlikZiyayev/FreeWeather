//
//  BaseViewController.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import UIKit


class BaseViewController: UIViewController
{
    let baseViewModel = BaseViewModel()
    
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
                  let safeCurrentTemp = forecastDays else { return }
            
            safeSelf.forecastDaysTableView.reloadData()
        }
    }
}



extension BaseViewController: UITableViewDelegate, UITableViewDataSource
{
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let safeForecastResponse = self.baseViewModel.forecastResponse.value
        {
            return safeForecastResponse?.forecast.forecastday.count ?? 0
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastSingleDayCell", for: indexPath)
        
        if let safeForecast = self.baseViewModel.forecastResponse.value,
           let safeForecastDay = safeForecast?.forecast.forecastday[indexPath.row]
        {
            cell.textLabel?.text = "\(String(safeForecastDay.date))"
        }
        
        return cell
    }
    
    
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
