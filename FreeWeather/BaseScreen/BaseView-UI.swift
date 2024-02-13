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
        self.baseTempLabel = self.create_baseTempLabel()
    }
    
    
    
    func setup_view()
    {
        self.title = "Free weather"
        self.view.backgroundColor = .white
    }
    
    
    
    func create_baseTempLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "0°C"
        label.font = .boldSystemFont(ofSize: 47)
        label.textColor = .black
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        
        
        return label
    }
}
