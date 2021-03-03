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
                case getLocalWeatherData(tempType: TemperatureSettings)
                case deleteCity(weatherID: Int, tempType: TemperatureSettings)
            }
        }
        struct Response {
            enum ResponseType {
                case presentWeather(weatherInCities: [WeatherResponse], tempType: TemperatureSettings)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayWeather(citySettingsViewModel: CitySettingsViewModel)
            }
        }
    }
}

struct CitySettingsViewModel {
    struct Cell: CitySettingsCellViewModel {
        var id: Int
        
        var cityName: String
        var temperature: String
    }
    var cells: [Cell]
}
