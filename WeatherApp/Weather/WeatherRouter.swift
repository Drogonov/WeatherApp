//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - WeatherRouting Protocols

protocol WeatherRoutingLogic {
    func showCitySettingsVC(tempType: TemperatureSettings)
    
    var dataSource: WeatherRouterDataSource? { get set }
    var dataDestination: WeatherRouterDataDestination? { get set }
}

protocol WeatherRouterDataSource: class {

}

protocol WeatherRouterDataDestination: class {
    //tempType from CitySettingsViewController
    var tempType: TemperatureSettings? { get set }
    //weather after changes from CitySettingsInteractor
    var weather: WeatherResponse? { get set }
}

class WeatherRouter: NSObject, WeatherRoutingLogic {
    
    // MARK: - Properties
    
    weak var viewController: WeatherViewController?
    var dataSource: WeatherRouterDataSource?
    var dataDestination: WeatherRouterDataDestination?
    
    // MARK: - Init
    
    init(viewController: WeatherViewController,
         dataSource: WeatherRouterDataSource,
         dataDestination: WeatherRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Routing
    
    func showCitySettingsVC(tempType: TemperatureSettings) {
        if let navVC = viewController?.navigationController {
            let citySettingsVC = CitySettingsViewController(tempType: tempType)
            navVC.pushViewController(citySettingsVC, animated: true)
        }
    }
}
