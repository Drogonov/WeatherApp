//
//  CitySettingsViewController.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CitySettingsDisplayLogic: class {
    func displayData(viewModel: CitySettings.Model.ViewModel.ViewModelData)
}

class CitySettingsViewController: UIViewController, CitySettingsDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: CitySettingsBusinessLogic?
    var router: (NSObjectProtocol & CitySettingsRoutingLogic)?

    private var tempType: TemperatureSettings
    private var citySettingsViewModel = CitySettingsViewModel.init(cells: [])
    private lazy var settingsTableView = CitySettingsTableView(frame: .zero, tempType: tempType)
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = CitySettingsInteractor()
        let presenter             = CitySettingsPresenter()
        let router                = CitySettingsRouter(viewController: viewController,
                                                       dataSource: interactor,
                                                       dataDestination: interactor)
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    private func showWeatherVC() {
        router?.showWeatherVC()
    }
    
    private func showCityAddVC() {
        router?.showCityAddVC()
    }
    
    private func passChangedWeather() {
        router?.passChangedWeather()
    }
    
    private func passChangedTempType() {
        router?.passChangedTempType()
    }
    
    
    // MARK: View lifecycle
    
    init(tempType: TemperatureSettings) {
        self.tempType = tempType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getLocalWeatherData(tempType: tempType)
        configureUI()
    }
    
    // MARK: - Requests
    
    private func getLocalWeatherData(tempType: TemperatureSettings) {
        interactor?.makeRequest(request: CitySettings.Model.Request.RequestType.getLocalWeatherData(tempType: tempType))
    }
    
    private func deleteCityRequest(weatherID: Int, tempType: TemperatureSettings) {
        interactor?.makeRequest(request: CitySettings.Model.Request.RequestType.deleteCity(weatherID: weatherID,
                                                                                                tempType: tempType))
    }
    
    private func changeTempTypeRequest(tempType: TemperatureSettings) {
        interactor?.makeRequest(request: CitySettings.Model.Request.RequestType.changeTempType(tempType: tempType))
    }
    
    private func getWeatherData(tempType: TemperatureSettings) {
        interactor?.makeRequest(request: CitySettings.Model.Request.RequestType.getWeatherData(tempType: tempType))
    }
    
    // MARK: - Display Data
    
    func displayData(viewModel: CitySettings.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeather(citySettingsViewModel: let citySettingsViewModel):
            self.citySettingsViewModel = citySettingsViewModel
            print("DEBUG: CitySettingsViewController citySettingsViewModel \(citySettingsViewModel)")
            configureUI()
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            showWeatherVC()
        }
    }
    
    // MARK: - ConfigureUI Functions
    
    private func configureUI() {
        view.backgroundColor = UIColor.backgroundColorWhite()
        configureNavigationController()
        configureSwipeGesture()
        configureTableView()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTableView() {
        settingsTableView.delegate = self
        view.addSubview(settingsTableView)
        settingsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                     leading: view.safeAreaLayoutGuide.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.safeAreaLayoutGuide.rightAnchor)
        settingsTableView.set(viewModel: citySettingsViewModel)
    }
    
    private func configureSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
}

// MARK: - CitySettingsTableViewDelegate

extension CitySettingsViewController: CitySettingsTableViewDelegate {
    func refresh(_ sender: AnyObject) {
        getWeatherData(tempType: tempType)
    }
    
    
    func deleteCity(weatherID: Int, tempType: TemperatureSettings) {
        deleteCityRequest(weatherID: weatherID, tempType: tempType)
        self.passChangedWeather()
    }
    
    func changeTempType(changedTempType: TemperatureSettings) {
        changeTempTypeRequest(tempType: changedTempType)
        self.passChangedTempType()
    }
    
    func plusButtonTapped() {
        showCityAddVC()
    }
}
