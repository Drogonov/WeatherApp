//
//  CitySettingsWorker.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CitySettingsService {
    var dataService: DataService
    
    init() {
        self.dataService = DataService()
    }
    
    func getWeatherArray() -> [WeatherResponse]? {
        return dataService.getWeatherArray()
    }
    
    func deleteCity(weatherID: Int) -> [WeatherResponse]? {
        let weather = dataService.deleteCity(weatherID: weatherID)
        return weather
    }
}
