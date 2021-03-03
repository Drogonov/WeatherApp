//
//  CityAddViewController.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CityAddDisplayLogic: class {
    func displayData(viewModel: CityAdd.Model.ViewModel.ViewModelData)
}

class CityAddViewController: UIViewController, CityAddDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: CityAddBusinessLogic?
    var router: (NSObjectProtocol & CityAddRoutingLogic)?
    
    let cityAddView = CityAddView()
    
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
    
    // MARK: Requests
    
    func getWeatherInCity(cityName: String) {
        interactor?.makeRequest(request: CityAdd.Model.Request.RequestType.getWeatherInCity(cityName: cityName))
    }
    
    // MARK: Display Data
    
    func displayData(viewModel: CityAdd.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeatherInCity(config: let config, cityName: let cityName):
            print("DEBUG: CityAddViewController city with name: \(cityName), loaded with config: \(config)")
            switch config {
            case .error:
                showNotification(title: "Что-то пошло не так",
                                 message: "Проверьте подключен ли интернет и правильно ли указан город \(cityName)",
                                 defaultAction: true,
                                 defaultActionText: "Ok",
                                 completion: {})
            case .success:
                showNotification(title: "Город \(cityName) успешно добавлен ",
                                 defaultAction: true,
                                 defaultActionText: "Ok", completion: {
                                    self.passLoadedWeather()
                                 })
            }
        }
    }
    
    // MARK: - Selectors
        
    @objc func Keyboard(notification: Notification) {
        if notification.name == UIResponder.keyboardWillHideNotification {
        view.layoutIfNeeded()
        }
    }
    
    // MARK: - ConfigureUI Functions
    
    func configureUI() {
        view.backgroundColor = UIColor.backgroundColorWhite()
        configureNavigationController()
        configureCityAddView()
        configureKeyboard()
    }
    
    func configureCityAddView() {
        cityAddView.delegate = self
        
        view.addSubview(cityAddView)
        cityAddView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leftAnchor,
                           trailing: view.safeAreaLayoutGuide.rightAnchor,
                           height: 300)
    }
    
    func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureKeyboard() {
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

// MARK: - CityAddViewDelegate

extension CityAddViewController: CityAddViewDelegate {
    func okButtonTapped(withButton button: UIButton) {
        guard let cityName = cityAddView.cityNameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        getWeatherInCity(cityName: cityName)
    }
    
    func rejectButtonTapped(withButton button: UIButton) {
        showCitySettingsVC()
    }
}
