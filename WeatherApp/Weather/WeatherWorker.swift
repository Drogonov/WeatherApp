//
//  WeatherWorker.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class WeatherService {
    
    var dataService: DataService
    
    init() {
        self.dataService = DataService()
    }
    
    func fetchWeatherInCities(weatherToFetch: [WeatherResponse], completion: @escaping([WeatherResponse?]) -> Void) {
        dataService.fetchWeatherInCities(weatherToFetch: weatherToFetch, completion: completion)
    }
    
    func getWeatherArray() -> [WeatherResponse]? {
        return dataService.getWeatherArray()
    }
}
