//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherPresentationLogic {
    func presentData(response: Weather.Model.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentationLogic {
    weak var viewController: WeatherDisplayLogic?
  
    func presentData(response: Weather.Model.Response.ResponseType) {
        switch response {
        case .presentWeather(weatherInCities: let weatherInCity):
            var cells = [WeatherViewModel.Cell]()
            for i in 0..<weatherInCity.count {
                let cell = cellViewModel(weather: weatherInCity[i])
                cells.append(cell)
            }
            
            let weatherViewModel = WeatherViewModel.init(cells: cells)
            viewController?.displayData(viewModel: Weather.Model.ViewModel.ViewModelData.displayWeather(weatherViewModel: weatherViewModel))
        } 
    }
    
    private func cellViewModel(weather: WeatherResponse?) -> WeatherViewModel.Cell {
        return WeatherViewModel.Cell.init(id: weather?.id ?? 0,
                                          cityName: weather?.name ?? "Добавьте город",
                                          temperature: String(weather?.main.temp ?? 0),
                                          description: weather?.weather.first?.description ?? "")
    }
  
}
