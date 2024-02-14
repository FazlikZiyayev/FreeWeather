//
//  SingleDayViewController.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 14/02/24.
//

import UIKit

class SingleDayViewController: UIViewController 
{
    let singleDayViewModel = SingleDayViewModel()
    
    var forecastHoursTableView = UITableView()

    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.create_uiComponents()
        self.bind_elements()
    }
    

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    
    
    func configuration(singleDay: ForecastDay)
    {
        self.singleDayViewModel.setSingleDay(singleDay: singleDay)
        
        self.view.backgroundColor = .white
        self.title = singleDay.date.dayName()
    }
}




// for binding elements
extension SingleDayViewController
{
    func bind_elements()
    {
        self.bind_forecastHoursTableView()
    }
    
    
    
    func bind_forecastHoursTableView()
    {
        self.singleDayViewModel.singleDay.bind { [weak self] singleDay in
            guard let safeSelf = self,
                  let _ = singleDay else { return }
            
            safeSelf.forecastHoursTableView.reloadData()
        }
    }
}



extension SingleDayViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return self.singleDayViewModel.getSingleDay()?.hour.count ?? 0
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastHourCell", for: indexPath)
        
        if let hours = self.singleDayViewModel.getSingleDay()?.hour
        {
            if let safeHourStr = hours[indexPath.row].time.onlyHours()
            {
                cell.textLabel?.text = "\(safeHourStr):   \(hours[indexPath.row].temp_c)°C"
            }
        }
        
        
        return cell
    }
}
