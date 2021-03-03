//
//  CitySettingsPresenter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - CitySettingsPresentationLogic Protocol

protocol CitySettingsPresentationLogic {
    func presentData(response: CitySettings.Model.Response.ResponseType)
}

// MARK: - CitySettingsPresenter

class CitySettingsPresenter: CitySettingsPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: CitySettingsDisplayLogic?
    
    // MARK: - Responce
    
    func presentData(response: CitySettings.Model.Response.ResponseType) {
        switch response {
        case .presentWeather(weatherInCities: let weatherInCities,
                             tempType: let tempType):
            
            let citySettingsViewModel = configureCells(weatherInCities: weatherInCities,
                                                       tempType: tempType)
            
            viewController?.displayData(viewModel: CitySettings.Model.ViewModel.ViewModelData.displayWeather(citySettingsViewModel: citySettingsViewModel))
        }
    }
    
    // MARK: - Helper Functions
    
    func configureCells(weatherInCities: [WeatherResponse?], tempType: TemperatureSettings) -> CitySettingsViewModel {
        var cells = [CitySettingsViewModel.Cell]()
        let citySettingsViewModel = CitySettingsViewModel.init(cells: [])
        for i in 0..<weatherInCities.count {
            guard let weatherInCity = weatherInCities[i] else { return citySettingsViewModel }
            let cell = cellViewModel(weather: weatherInCity, tempType: tempType)
            cells.append(cell)
        }
        
        return CitySettingsViewModel.init(cells: cells)
    }
    
    
    private func cellViewModel(weather: WeatherResponse, tempType: TemperatureSettings) -> CitySettingsViewModel.Cell {
        let id = weather.id
        let cityName = weather.name
        let temp = weather.main.temp
        let temperature: String
        
        switch tempType {
        case .celsius:
            temperature = String(format: "%.2f", temp - 273.15) + "°"
        case .fahrenheit:
            temperature = String(format: "%.2f", (9/5)*(temp - 273.15 + 32)) + " F°"
        }
        
        return CitySettingsViewModel.Cell.init(id: id,
                                               cityName: cityName,
                                               temperature: temperature)
    }
}
