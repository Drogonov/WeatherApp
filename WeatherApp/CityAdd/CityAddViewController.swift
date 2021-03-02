//
//  CityAddViewController.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum LoadingDataConfiguration: String {
    case error
    case success
    
    init() {
        self = .success
    }
}

protocol CityAddDisplayLogic: class {
    func displayData(viewModel: CityAdd.Model.ViewModel.ViewModelData)
}

class CityAddViewController: UIViewController, CityAddDisplayLogic {
    
    var interactor: CityAddBusinessLogic?
//    var router: (NSObjectProtocol & CityAddRoutingLogic)?
    var router: CityAddRouter?
    
    let cityAddView = CityAddView()
    
    // MARK: Object lifecycle
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = CityAddInteractor()
        let presenter             = CityAddPresenter()
        let router                = CityAddRouter(viewController: viewController,
                                                  dataSource: interactor,
                                                  dataDestination: interactor)
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    func showCitySettingsVC() {
        router?.showCitySettingsVC()
    }
    
    func passLoadedWeather() {
        router?.passLoadedWeather()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    func displayData(viewModel: CityAdd.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeatherInCity(config: let config):
            print("displayData")
            print(config)
            passLoadedWeather()
        }
    }
    
    // MARK: - Helper Functions
    
    func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.backgroundColorWhite()
        configureNavigationController()
        
        cityAddView.delegate = self
        
        view.addSubview(cityAddView)
        cityAddView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leftAnchor,
                           trailing: view.safeAreaLayoutGuide.rightAnchor,
                           height: 300)
    }
}

// MARK: - CityAddViewDelegate

extension CityAddViewController: CityAddViewDelegate {
    func okButtonTapped(withButton button: UIButton) {
        guard let cityName = cityAddView.cityNameTextField.text else { return }
        interactor?.makeRequest(request: CityAdd.Model.Request.RequestType.getWeatherInCity(cityName: cityName))
    }
    
    func rejectButtonTapped(withButton button: UIButton) {
        showCitySettingsVC()
    }
}
