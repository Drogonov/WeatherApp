//
//  CityAddPresenter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - CityAddPresentationLogic Protocol

protocol CityAddPresentationLogic {
    func presentData(response: CityAdd.Model.Response.ResponseType)
}

// MARK: - CityAddPresenter

class CityAddPresenter: CityAddPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: CityAddDisplayLogic?
    
    // MARK: - Responce
    
    func presentData(response: CityAdd.Model.Response.ResponseType) {
        switch response {

        case .presentWeatherInCity(config: let config, cityName: let cityName):
            viewController?.displayData(viewModel: CityAdd.Model.ViewModel.ViewModelData.displayWeatherInCity(config: config, cityName: cityName))
        }
    }
}
