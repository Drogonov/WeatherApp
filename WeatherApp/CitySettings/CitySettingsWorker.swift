//
//  CitySettingsWorker.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CitySettingsService {
    
    // MARK: - Properties
    
    private var dataService: DataService
    
    // MARK: - Init
    
    init() {
        self.dataService = DataService()
    }
    
    //MARK: - Service Functions
    
    func fetchWeatherInCities(weatherToFetch: [WeatherResponse], completion: @escaping([WeatherResponse?]) -> Void) {
        dataService.fetchWeatherInCities(weatherToFetch: weatherToFetch, completion: completion)
    }
    
    func getWeatherArray() -> [WeatherResponse]? {
        return dataService.getWeatherArray()
    }
    
    func deleteCity(weatherID: Int) -> [WeatherResponse]? {
        let weather = dataService.deleteCity(weatherID: weatherID)
        return weather
    }
    
    func getTempType() -> TemperatureSettings {
        return dataService.getTempType()
    }
    
    func saveTempType(temp : TemperatureSettings) {
        dataService.saveTempType(temp: temp)
    }
}
