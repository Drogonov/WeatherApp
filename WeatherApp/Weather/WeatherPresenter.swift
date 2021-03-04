//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - WeatherPresentationLogic Protocol

protocol WeatherPresentationLogic {
    func presentData(response: Weather.Model.Response.ResponseType)
}

// MARK: - WeatherPresenter

class WeatherPresenter: WeatherPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: WeatherDisplayLogic?
    
    // MARK: - Responce
  
    func presentData(response: Weather.Model.Response.ResponseType) {
        switch response {
        case .presentWeather(weatherInCities: let weatherInCities,
                             tempType: let tempType):
        
            let weatherViewModel = configureCells(weatherInCities: weatherInCities,
                                                  tempType: tempType)
            viewController?.displayData(viewModel: Weather.Model.ViewModel.ViewModelData.displayWeather(weatherViewModel: weatherViewModel))
        case .tempTypeWasChanged(tempType: let tempType):
            viewController?.displayData(viewModel: Weather.Model.ViewModel.ViewModelData.displayChangedTempType(tempType: tempType))
        }
    }
    
    // MARK: - Helper Functions
    
    func configureCells(weatherInCities: [WeatherResponse?], tempType: TemperatureSettings) -> WeatherViewModel {
        var cells = [WeatherViewModel.Cell]()
        let weatherViewModel = WeatherViewModel.init(cells: [])
        for i in 0..<weatherInCities.count {
            guard let weatherInCity = weatherInCities[i] else { return weatherViewModel }
            let cell = cellViewModel(weather: weatherInCity, tempType: tempType)
            cells.append(cell)
        }
        
        return WeatherViewModel.init(cells: cells)
    }
    
    private func cellViewModel(weather: WeatherResponse, tempType: TemperatureSettings) -> WeatherViewModel.Cell {
        let id = weather.id
        let cityName = weather.name
        let temp = weather.main.temp
        let temperature: String
        let description = weather.weather.first?.description ?? ""
        
        switch tempType {
        case .celsius:
            temperature = String(format: "%.2f", temp - 273.15) + "°"
        case .fahrenheit:
            temperature = String(format: "%.2f", (9/5)*(temp - 273.15 + 32)) + " F°"
        }
        
        return WeatherViewModel.Cell.init(id: id,
                                          cityName: cityName,
                                          temperature: temperature,
                                          description: description)
    }
    
    private func cellSize() {
        
    }
}
