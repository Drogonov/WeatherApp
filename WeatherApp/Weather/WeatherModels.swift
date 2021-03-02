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
                case getWeatherData
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

struct WeatherViewModel {
    struct Cell: WeatherCellViewModel {
        var id: Int
        
        var cityName: String
        var temperature: String
        var description: String
    }
    
    var cells: [Cell]
}
