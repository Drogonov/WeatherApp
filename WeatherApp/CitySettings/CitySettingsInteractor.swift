//
//  CitySettingsInteractor.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - CitySettingsLogic Protocol

protocol CitySettingsBusinessLogic {
    func makeRequest(request: CitySettings.Model.Request.RequestType)
}

// MARK: - CityAddRouting Protocols

protocol CitySettingsDataSource {
    var changedTempType: TemperatureSettings? { get }
    var changedWeather: WeatherResponse? { get }
}

protocol CitySettingsDataDestination {
    var weather: WeatherResponse? { get set }
}

// MARK: - CitySettingsInteractor

class CitySettingsInteractor: CitySettingsBusinessLogic, CitySettingsDataSource, CitySettingsDataDestination {

    // MARK: - Properties
    
    var presenter: CitySettingsPresentationLogic?
    var service: CitySettingsService?
    var weather: WeatherResponse? {
        didSet {
            getLocalWeatherData(tempType: getTempType())
        }
    }
    var changedWeather: WeatherResponse?
    var changedTempType: TemperatureSettings?
    
    // MARK: - Request
    
    func makeRequest(request: CitySettings.Model.Request.RequestType) {
        if service == nil {
            service = CitySettingsService()
        }
        
        switch request {
        case .getLocalWeatherData(tempType: let tempType):
            getLocalWeatherData(tempType: tempType)
        case .deleteCity(weatherID: let weatherID, tempType: let tempType):
            deleteCity(weatherID: weatherID, tempType: tempType)
        }
    }
    
    // MARK: - Helping Functions
    
    func getLocalWeatherData(tempType: TemperatureSettings) {
        let weatherInCities = service?.getWeatherArray()
        guard let weather = weatherInCities else { return }
        self.changedTempType = tempType
        presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: weather, tempType: tempType))
    }
    
    func deleteCity(weatherID: Int, tempType: TemperatureSettings) {
        let weatherInCities = service?.deleteCity(weatherID: weatherID)
        guard let weather = weatherInCities else { return }
        //MARK: - CRUTCH
        self.changedWeather = weather.first
        presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: weather, tempType: tempType))
    }
    
    func getTempType() -> TemperatureSettings {
        return service?.getTempType() ?? .celsius
    }
}

// MARK: - CitySettingsRouter Extensions

extension CitySettingsInteractor: CitySettingsRouterDataSource, CitySettingsRouterDataDestination {
}
