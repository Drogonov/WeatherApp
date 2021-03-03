//
//  CityAddRouter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - CityAddRouting Protocols

protocol CityAddRoutingLogic {
    var dataSource: CityAddRouterDataSource? { get set }
    var dataDestination: CityAddRouterDataDestination? { get set }
    
    
    func showCitySettingsVC()
    func passLoadedWeather()
}

protocol CityAddRouterDataSource: class {
    // weather loaded in CityAddInteractor
    var loadedWeather: WeatherResponse? { get }
}
protocol CityAddRouterDataDestination: class {

}

class CityAddRouter: NSObject, CityAddRoutingLogic {
    
    // MARK: - Properties
    
    weak var viewController: CityAddViewController?
    weak var dataSource: CityAddRouterDataSource?
    weak var dataDestination: CityAddRouterDataDestination?
    
    // MARK: - Init
    
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
        // Yes i know it is a CRUTCH but i have read tons of articles about clean swift and found info about passing data from Child VC to Parent VC by segues and storyboards! But how it should work with navigation controller wich was made programmatically when i havent properties?! I used to use delegation and it works fine when i was working with MVC. If said by true i almost diseded to ruin all achitecture here and implement delegates to pass data, but suddenly i understand that this stuff will work from me.
        
        if let citySettingsVC = viewController?.navigationController?.previousViewController() as? CitySettingsViewController {
            citySettingsVC.router?.dataDestination?.weather = dataSource?.loadedWeather
            
            if let weatherVC = citySettingsVC.navigationController?.previousViewController() as? WeatherViewController {
                weatherVC.router?.dataDestination?.weather = dataSource?.loadedWeather
            }
        }
    }
}
