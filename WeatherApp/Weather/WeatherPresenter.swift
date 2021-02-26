//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherPresentationLogic {
  func presentData(response: Weather.Model.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentationLogic {
  weak var viewController: WeatherDisplayLogic?
  
  func presentData(response: Weather.Model.Response.ResponseType) {
  
  }
  
}
