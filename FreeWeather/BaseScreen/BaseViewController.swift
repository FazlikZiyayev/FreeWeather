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
}
