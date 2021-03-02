//
//  CitySettingsModels.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CitySettings {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getLocalWeatherData
                case deleteCity(weatherID: Int)
            }
        }
        struct Response {
            enum ResponseType {
                case presentWeather(weatherInCities: [WeatherResponse?])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayWeather(weatherViewModel: WeatherViewModel)
            }
        }
    }
    
}
