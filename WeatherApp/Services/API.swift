//
//  API.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation

struct API {
    static let scheme = "http"
    static let host = "api.openweathermap.org"
    static let key = "65a9d42c92fec5c6170c409c073335f6"
    static let language = "ru"
    
    static let getCityWeather = "/data/2.5/weather"
}
