//
//  CityAddInteractor.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - CityAddBusinessLogic Protocol

protocol CityAddBusinessLogic {
    func makeRequest(request: CityAdd.Model.Request.RequestType)
}

// MARK: - CityAddRouting Protocols

protocol CityAddDataSource {
    var loadedWeather: WeatherResponse? { get }
}

protocol CityAddDataDestination {

}

// MARK: - CityAddInteractor

class CityAddInteractor: CityAddBusinessLogic, CityAddDataSource, CityAddDataDestination {
    
    // MARK: - Properties
        
    var presenter: CityAddPresentationLogic?
    var service: CityAddService?
    var loadedWeather: WeatherResponse?
    
    // MARK: - Request
    
    func makeRequest(request: CityAdd.Model.Request.RequestType) {
        if service == nil {
            service = CityAddService()
        }
        
        switch request {
        case .getWeatherInCity(cityName: let cityName):
            getWeatherInCity(cityName: cityName)
        }
    }
    
    // MARK: - Helping Functions
    
    func getWeatherInCity(cityName: String) {
        service?.getWeatherInCity(cityName: cityName, completion: { (config, weather) in
            self.loadedWeather = weather
            self.presenter?.presentData(response: CityAdd.Model.Response.ResponseType.presentWeatherInCity(config: config, cityName: cityName))
        })
    }
}

// MARK: - CityAddRouter Extensions

extension CityAddInteractor: CityAddRouterDataSource, CityAddRouterDataDestination {
}
