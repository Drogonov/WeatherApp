//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherRoutingLogic {
    func showCitySettingsVC(tempType: TemperatureSettings)
}

class WeatherRouter: NSObject, WeatherRoutingLogic {

    weak var viewController: WeatherViewController?
  
    // MARK: Routing
    
    func showCitySettingsVC(tempType: TemperatureSettings) {
        if let navVC = viewController?.navigationController {
            let citySettingsVC = CitySettingsViewController(tempType: tempType)
            navVC.pushViewController(citySettingsVC, animated: true)
        }
    }
}
