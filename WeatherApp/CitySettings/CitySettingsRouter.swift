//
//  CitySettingsRouter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - CitySettingsRouting Protocols

protocol CitySettingsRoutingLogic {
    var dataSource: CitySettingsRouterDataSource? { get set }
    var dataDestination: CitySettingsRouterDataDestination? { get set }
    
    func showWeatherVC()
    func showCityAddVC()
    func passChangedTempType()
    func passChangedWeather()
}

protocol CitySettingsRouterDataSource: class {
    //tempType changed in CitySettingsViewController
    var changedTempType: TemperatureSettings? { get }
    //weather changed by deleting row or adding new weather from CityAddInteractor
    var changedWeather: [WeatherResponse]? { get }
}

protocol CitySettingsRouterDataDestination: class {
    // weather from CityAddInteractor
    var weather: [WeatherResponse]? { get set }
}

class CitySettingsRouter: NSObject, CitySettingsRoutingLogic {
    
    // MARK: - Properties

    weak var viewController: CitySettingsViewController?
    weak var dataSource: CitySettingsRouterDataSource?
    weak var dataDestination: CitySettingsRouterDataDestination?
    
    // MARK: - Init
    
    init(viewController: CitySettingsViewController,
         dataSource: CitySettingsRouterDataSource,
         dataDestination: CitySettingsRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Routing
        
    func showWeatherVC() {
        if let navVC = viewController?.navigationController {
            print("DEBUG: show WeatherViewController from CitySettingsViewController")
            passChangedWeather()
            navVC.popViewController(animated: true)
        }
    }
    
    func showCityAddVC() {
        if let navVC = viewController?.navigationController {
            print("DEBUG: show CityAddViewController from CitySettingsViewController")
            let cityAddVC = CityAddViewController()
            navVC.pushViewController(cityAddVC, animated: true)
        }
    }
    
    func passChangedTempType() {
        if let weatherVC = viewController?.navigationController?.previousViewController() as? WeatherViewController {
            print("DEBUG: tempType data passed from CitySettingsRouter to WeatherRouter \(String(describing: dataSource?.changedTempType))")
            weatherVC.router?.dataDestination?.tempType = dataSource?.changedTempType
        }
    }
    
    func passChangedWeather() {
        if let weatherVC = viewController?.navigationController?.previousViewController() as? WeatherViewController {
            print("DEBUG: weather data passed from CitySettingsRouter to WeatherRouter \(String(describing: dataSource?.changedWeather))")
            weatherVC.router?.dataDestination?.weather = dataSource?.changedWeather
        }
        
    }
}


