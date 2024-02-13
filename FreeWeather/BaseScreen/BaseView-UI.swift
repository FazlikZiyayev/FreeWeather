//
//  BaseView-UI.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import UIKit
import SnapKit


extension BaseViewController
{
    func create_uiComponents()
    {
        self.locationLabel = self.create_locationLabel()
        self.currentTempLabel = self.create_currentTempLabel()
    }
    
    
    
    func setup_view()
    {
        self.title = "Free weather"
        self.view.backgroundColor = .white
    }
    
    
    
    func create_locationLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "--"
        label.font = .boldSystemFont(ofSize: 54)
        label.textColor = .black
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        
        
        return label
    }
    
    
    func create_currentTempLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "-°C"
        label.font = .boldSystemFont(ofSize: 47)
        label.textColor = .black
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.locationLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        
        return label
    }
}
