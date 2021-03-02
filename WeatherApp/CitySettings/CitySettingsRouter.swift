//
//  CitySettingsRouter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CitySettingsRoutingLogic {
    func showWeatherVC()
    func showCityAddVC()
}

protocol CitySettingsRouterDataSource: class {

}

protocol CitySettingsRouterDataDestination: class {
    var weather: WeatherResponse? { get set }
}

class CitySettingsRouter: NSObject, CitySettingsRoutingLogic {

    weak var viewController: CitySettingsViewController?
    weak var dataSource: CitySettingsRouterDataSource?
    weak var dataDestination: CitySettingsRouterDataDestination?
    
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
            navVC.popViewController(animated: true)
        }
    }
    
    func showCityAddVC() {
        if let navVC = viewController?.navigationController {
            let cityAddVC = CityAddViewController()
            navVC.pushViewController(cityAddVC, animated: true)
        }
    }
    
}


