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
    var changedWeather: [WeatherResponse]? { get }
}

protocol CitySettingsDataDestination {
    var weather: [WeatherResponse]? { get set }
}

// MARK: - CitySettingsInteractor

class CitySettingsInteractor: CitySettingsBusinessLogic, CitySettingsDataSource, CitySettingsDataDestination {

    // MARK: - Properties
    
    var presenter: CitySettingsPresentationLogic?
    var service: CitySettingsService?
    var weather: [WeatherResponse]? {
        didSet {
            print("did set weather in CitySettingsInteractor")
            getLocalWeatherData(tempType: getTempType())
        }
    }
    var changedWeather: [WeatherResponse]?
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
        case .changeTempType(tempType: let tempType):
            saveTempType(temp: tempType)
        case .getWeatherData(tempType: let tempType):
            getWeatherData(tempType: tempType)
        }
    }
    
    // MARK: - Helping Functions
    
    func getWeatherData(tempType: TemperatureSettings) {
        let weatherInCities = service?.getWeatherArray()
        guard let weather = weatherInCities else { return }
        service?.fetchWeatherInCities(weatherToFetch: weather, completion: { [weak self] (responce) in
            self?.presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: responce, tempType: tempType))
        })
    }
    
    func getLocalWeatherData(tempType: TemperatureSettings) {
        let weatherInCities = service?.getWeatherArray()
        guard let weather = weatherInCities else { return }
        self.changedWeather = weather
        presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: weather, tempType: tempType))
    }
    
    func deleteCity(weatherID: Int, tempType: TemperatureSettings) {
        let weatherInCities = service?.deleteCity(weatherID: weatherID)
        guard let weather = weatherInCities else { return }
        self.changedWeather = weather
        presenter?.presentData(response: CitySettings.Model.Response.ResponseType.presentWeather(weatherInCities: weather, tempType: tempType))
    }
    
    func getTempType() -> TemperatureSettings {
        return service?.getTempType() ?? .celsius
    }
    
    func saveTempType(temp : TemperatureSettings) {
        changedTempType = temp
        service?.saveTempType(temp: temp)
        getLocalWeatherData(tempType: temp)
    }
}

// MARK: - CitySettingsRouter Extensions

extension CitySettingsInteractor: CitySettingsRouterDataSource, CitySettingsRouterDataDestination {
}
