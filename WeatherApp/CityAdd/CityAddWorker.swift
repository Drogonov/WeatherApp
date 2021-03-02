//
//  CityAddWorker.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CityAddService {
    var dataService: DataService
    let userDefaults = UserDefaults.standard
    
    init() {
        self.dataService = DataService()
    }
    
    func getWeatherInCity(cityName: String, completion: @escaping(LoadingDataConfiguration, WeatherResponse?) -> Void) {
        dataService.fetchWeatherInCity(cityName: cityName) { (weather) in
            guard let weatherInCity = weather else { return completion(.error, weather) }
            self.dataService.saveWeatherInCity(weather: weatherInCity)
            completion(.success, weather)
        }
    }
}
