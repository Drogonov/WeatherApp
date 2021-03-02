//
//  CitySettingsInteractor.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CitySettingsBusinessLogic {
    func makeRequest(request: CitySettings.Model.Request.RequestType)
}

protocol CitySettingsDataSource {

}

protocol CitySettingsDataDestination {
    var weather: WeatherResponse? { get set }
}

class CitySettingsInteractor: CitySettingsBusinessLogic, CitySettingsDataSource, CitySettingsDataDestination {

    var presenter: CitySettingsPresentationLogic?
    var service: CitySettingsService?
    var weather: WeatherResponse?
    
    func makeRequest(request: CitySettings.Model.Request.RequestType) {
        if service == nil {
            service = CitySettingsService()
        }
        
        switch request {
        case .getLocalWeatherData:
            let weatherInCities = service?.getWeatherArray()
            guard var weather = weatherInCities else { return }
            
            if let loadedWeather = self.weather {
                weather.append(loadedWeather)
            }
            
            presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: weather))
        case .deleteCity(weatherID: let weatherID):
            let weatherInCities = service?.deleteCity(weatherID: weatherID)
            guard let weather = weatherInCities else { return }
            presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: weather))
        }
    }
}

extension CitySettingsInteractor: CitySettingsRouterDataSource, CitySettingsRouterDataDestination {
}
