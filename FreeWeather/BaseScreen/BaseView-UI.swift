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
        self.limitStackView = self.create_limitStackView()
        
        self.forecastDaysTableView = self.create_forecastDaysTableView()
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
    
    
    
    func create_limitStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        // Create buttons
        let arr = [3,7,10]
        for i in arr {
            let button = UIButton(type: .system)
            button.tag = i
            button.setTitle("\(i)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.tintColor = UIColor.black
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(limitBtnPressed), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
        
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.currentTempLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        
        return stackView
    }
    
    
    
    func create_forecastDaysTableView() -> UITableView
    {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.register(ForecastSingleDayCell.self, forCellReuseIdentifier: "ForecastSingleDayCell")

        tb.backgroundColor = .white
        
        self.view.addSubview(tb)
        
        tb.snp.makeConstraints { make in
            make.top.equalTo(self.limitStackView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        return tb
    }
}
