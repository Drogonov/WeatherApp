//
//  CitySettingsPresenter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CitySettingsPresentationLogic {
    func presentData(response: CitySettings.Model.Response.ResponseType)
}

class CitySettingsPresenter: CitySettingsPresentationLogic {
    weak var viewController: CitySettingsDisplayLogic?
    
    func presentData(response: CitySettings.Model.Response.ResponseType) {
        switch response {
        case .presentWeather(weatherInCities: let weatherInCity):
            var cells = [WeatherViewModel.Cell]()
            for i in 0..<weatherInCity.count {
                let cell = cellViewModel(weather: weatherInCity[i])
                cells.append(cell)
            }
            
            let weatherViewModel = WeatherViewModel.init(cells: cells)
            viewController?.displayData(viewModel: CitySettings.Model.ViewModel.ViewModelData.displayWeather(weatherViewModel: weatherViewModel))
        }
    }
    
    private func cellViewModel(weather: WeatherResponse?) -> WeatherViewModel.Cell {
        return WeatherViewModel.Cell.init(id: weather?.id ?? 0,
                                          cityName: weather?.name ?? "Добавьте город",
                                          temperature: String(weather?.main.temp ?? 0),
                                          description: weather?.weather.first?.description ?? "")
    }
}
