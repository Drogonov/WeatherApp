//
//  CityAddPresenter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CityAddPresentationLogic {
    func presentData(response: CityAdd.Model.Response.ResponseType)
}

class CityAddPresenter: CityAddPresentationLogic {
    weak var viewController: CityAddDisplayLogic?
    
    func presentData(response: CityAdd.Model.Response.ResponseType) {
        switch response {
        case .presentWeatherInCity(config: let config):
            viewController?.displayData(viewModel: CityAdd.Model.ViewModel.ViewModelData.displayWeatherInCity(config: config))
        }
    }
    
}
