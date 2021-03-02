//
//  CityAddRouter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CityAddRoutingLogic {
    func showCitySettingsVC()
}

protocol CityAddRouterDataSource: class {
    var loadedWeather: WeatherResponse? { get }
}
protocol CityAddRouterDataDestination: class {

}

class CityAddRouter: NSObject, CityAddRoutingLogic {
    
    weak var viewController: CityAddViewController?
    weak var dataSource: CityAddRouterDataSource?
    weak var dataDestination: CityAddRouterDataDestination?
    
    init(viewController: CityAddViewController,
         dataSource: CityAddRouterDataSource,
         dataDestination: CityAddRouterDataDestination) {
        
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Routing
    
    func showCitySettingsVC() {
        if let navVC = viewController?.navigationController {
            navVC.popViewController(animated: true)
        }
    }
    
    func passLoadedWeather() {
        let citySettingsVC = CitySettingsViewController(tempType: .celsius)
        citySettingsVC.router?.dataDestination?.weather = dataSource?.loadedWeather
    }
}
