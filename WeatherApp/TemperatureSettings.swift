//
//  TemperatureSettings.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation

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
