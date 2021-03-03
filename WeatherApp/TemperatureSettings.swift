//
//  TemperatureSettings.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation

protocol TemperatureType {
    var tempType: TemperatureSettings { get set }
}

struct TempType: TemperatureType {
    var tempType: TemperatureSettings
}

enum TemperatureSettings: String {

    case celsius = "C°"
    case fahrenheit = "/°F"
    
    init() {
        self = .celsius
    }
}

struct TemperatureSettingsValues {
    static let celsiusRawValue = "C°"
    static let fahrenheitRawValue = "/°F"
}
