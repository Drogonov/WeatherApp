//
//  CityAddModels.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CityAdd {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getWeatherInCity(cityName: String)
            }
        }
        struct Response {
            enum ResponseType {
                case presentWeatherInCity(config: LoadingDataConfiguration)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayWeatherInCity(config: LoadingDataConfiguration)
            }
        }
    }
    
}
