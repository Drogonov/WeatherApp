//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - WeatherBusinessLogic Protocol

protocol WeatherBusinessLogic {
    func makeRequest(request: Weather.Model.Request.RequestType)
}

// MARK: - CityAddRouting Protocols

protocol WeatherSettingsDataSource {

}

protocol WeatherDataDestination {
    var tempType: TemperatureSettings? { get set }
    var weather: [WeatherResponse]? { get set }
}

// MARK: - WeatherInteractor

class WeatherInteractor: WeatherBusinessLogic, WeatherSettingsDataSource, WeatherDataDestination {

    // MARK: - Properties
    
    var presenter: WeatherPresentationLogic?
    var service: WeatherService?
    var weather: [WeatherResponse]? {
        didSet {
            print("did set weather in WeatherInteractor")
            getLocalWeatherData(tempType: getTempType())
        }
    }
    var tempType: TemperatureSettings? {
        didSet {
            tempTypeWasChanged(tempType: tempType ?? .celsius)
        }
    }
    
    // MARK: - Request
  
    func makeRequest(request: Weather.Model.Request.RequestType) {
        if service == nil {
            service = WeatherService()
        }

        switch request {
        case .getWeatherData(tempType: let tempType):
            getWeatherData(tempType: tempType)
        case .getLocalWeatherData(tempType: let tempType):
            getLocalWeatherData(tempType: tempType)
        }
    }
    
    // MARK: - Helper Functions
    
    func getWeatherData(tempType: TemperatureSettings) {
        let weatherInCities = service?.getWeatherArray()
        guard let weather = weatherInCities else { return }
        service?.fetchWeatherInCities(weatherToFetch: weather, completion: { [weak self] (responce) in
            self?.presenter?.presentData(response: Weather.Model.Response.ResponseType.presentWeather(weatherInCities: responce, tempType: tempType))
        })
    }
    
    func getLocalWeatherData(tempType: TemperatureSettings) {
        let weatherInCities = service?.getWeatherArray()
        guard let weather = weatherInCities else { return }
        presenter?.presentData(response: Weather.Model.Response.ResponseType.presentWeather(weatherInCities: weather, tempType: tempType))
    }
    
    func tempTypeWasChanged(tempType: TemperatureSettings) {
        presenter?.presentData(response: Weather.Model.Response.ResponseType.tempTypeWasChanged(tempType: tempType))
    }
    
    func getTempType() -> TemperatureSettings {
        return service?.getTempType() ?? .celsius
    }
}

// MARK: - WeatherRouter Extensions

extension WeatherInteractor: WeatherRouterDataSource, WeatherRouterDataDestination {
}
