//
//  CityAddWorker.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CityAddService {
    
    // MARK: - Properties
    
    private var dataService: DataService
    
    //MARK: - Init
    
    init() {
        self.dataService = DataService()
    }
    
    //MARK: - Service Functions
    
    func getWeatherInCity(cityName: String, completion: @escaping(CityAdd.DataConfiguration, [WeatherResponse]?) -> Void) {
        dataService.fetchWeatherInCity(cityName: cityName) { (weather) in
            guard let weatherInCity = weather else { return completion(.error, []) }
            self.dataService.saveWeatherInCity(weather: weatherInCity)
            let weatherArray = self.dataService.getWeatherArray()
            completion(.success, weatherArray)
        }
    }
}
