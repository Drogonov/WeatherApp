//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation

struct WeatherResponse: Codable, Comparable {

    
    let id: Int
    let name: String
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
    }
    
    static func < (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        lhs.id < rhs.id
    }
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        lhs.id == rhs.id
    }
    
}
