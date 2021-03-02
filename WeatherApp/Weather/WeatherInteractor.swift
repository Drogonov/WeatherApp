//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherBusinessLogic {
    func makeRequest(request: Weather.Model.Request.RequestType)
}

class WeatherInteractor: WeatherBusinessLogic {
    var presenter: WeatherPresentationLogic?
    var service: WeatherService?
    
    var dataFetcherService = DataService()
  
    func makeRequest(request: Weather.Model.Request.RequestType) {
        if service == nil {
            service = WeatherService()
        }

        switch request {
        case .getWeatherData:
            let weatherInCities = service?.getWeatherArray()
            guard let weather = weatherInCities else { return }
            service?.fetchWeatherInCities(weatherToFetch: weather, completion: { [weak self] (responce) in
                self?.presenter?.presentData(response: Weather.Model.Response.ResponseType.presentWeather(weatherInCities: responce))
            })
        }
    }
}
