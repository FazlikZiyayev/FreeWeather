//
//  ViewController.swift
//  FreeWeather
//
//  Created by Fazlik Ziyaev on 13/02/24.
//

import UIKit

class ViewController: UIViewController {

    private let apiManager: APIManagerProtocol = APIManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        self.fetchData()
    }
    
    
    func fetchData()
    {
        let baseUrl = NetworkConstants.shared.serverEndpoint
        let apiKey = NetworkConstants.shared.apiKey
        
        guard let url = URL(string: baseUrl + "current.json?key=" + apiKey + "&q=Uzbekistan") else { return }
        
        self.apiManager.fetchDataViaAlamofire(from: url, headers: nil) { result in
            switch result {
            case .success(let data):
                if let stringData = String(data: data, encoding: .utf8) {
                    print("Data received successfully: \(stringData)")
                } else {
                    print("Unable to convert data to string.")
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

