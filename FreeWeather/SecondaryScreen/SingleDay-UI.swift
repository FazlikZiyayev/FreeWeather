//
//  SingleDay-UI.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 14/02/24.
//

import UIKit

extension SingleDayViewController
{
    func create_uiComponents()
    {
        self.forecastHoursTableView = self.create_forecastHoursTableView()
    }
    
    
    
    func create_forecastHoursTableView() -> UITableView
    {
        let tb = UITableView()
        tb.dataSource = self
        tb.register(ForecastSingleDayCell.self, forCellReuseIdentifier: "ForecastHourCell")

        tb.backgroundColor = .white
        
        self.view.addSubview(tb)
        
        tb.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        return tb
    }
}
