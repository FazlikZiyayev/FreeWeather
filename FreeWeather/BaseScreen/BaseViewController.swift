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
    
    var baseTempLabel = UILabel()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.baseViewModel.fetchCurrentTemp()
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
        self.baseViewModel.currentTemp.bind { [weak self] currentTemp in
            guard let self = self,
                  let safeCurrentTemp = currentTemp else { return }
            
            baseTempLabel.text = "\(safeCurrentTemp)°C"
        }
    }
}
