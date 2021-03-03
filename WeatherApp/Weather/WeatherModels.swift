//
//  WeatherModels.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Weather {
   
    enum Model {
        struct Request {
            enum RequestType {
                case getWeatherData(tempType: TemperatureSettings)
                case getLocalWeatherData(tempType: TemperatureSettings)
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentWeather(weatherInCities: [WeatherResponse?], tempType: TemperatureSettings)
                case tempTypeWasChanged(tempType: TemperatureSettings)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayWeather(weatherViewModel: WeatherViewModel)
                case displayChangedTempType(tempType: TemperatureSettings)
            }
        }
    }
}

struct WeatherViewModel {
    struct Cell: WeatherCellViewModel {
        var id: Int
        
        var cityName: String
        var temperature: String
        var description: String
    }
    
    var cells: [Cell]
}
