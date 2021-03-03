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
    
    var tempType: TemperatureSettings {
        didSet {
            getLocalWeatherData(tempType: tempType)
        }
    }
    
    private var citySettingsViewModel = CitySettingsViewModel.init(cells: [])
    private var citySettingsTableView = CitySettingsTableView()
    
    private lazy var footerView = CitySettingsTableViewFooter(frame: .zero, tempType: tempType)
    
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
    
    func showWeatherVC() {
        router?.showWeatherVC()
    }
    
    func showCityAddVC() {
        router?.showCityAddVC()
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
        print("viewDidLoad")
        view.backgroundColor = .blue
        setup()
        getLocalWeatherData(tempType: tempType)
        configureUI()
    }
    
    // MARK: - Requests
    
    func getLocalWeatherData(tempType: TemperatureSettings) {
        interactor?.makeRequest(request: CitySettings.Model.Request.RequestType.getLocalWeatherData(tempType: tempType))
    }
    
    func deleteCity(weatherID: Int, tempType: TemperatureSettings) {
        self.interactor?.makeRequest(request: CitySettings.Model.Request.RequestType.deleteCity(weatherID: weatherID,
                                                                                                tempType: tempType))
    }
    
    // MARK: - Display Data
    
    func displayData(viewModel: CitySettings.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeather(citySettingsViewModel: let citySettingsViewModel):
            self.citySettingsViewModel = citySettingsViewModel
            print(citySettingsViewModel)
            configureUI()
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            showWeatherVC()
        }
    }
    
    // MARK: - ConfigureUI Functions
    
    func configureUI() {
        configureNavigationController()
        configureSwipeGesture()
        configureTableView()
    }
    
    func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureTableView() {
        citySettingsTableView.delegate = self
        
        view.addSubview(citySettingsTableView)
        citySettingsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                     leading: view.safeAreaLayoutGuide.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.safeAreaLayoutGuide.rightAnchor)
        citySettingsTableView.set(weather: citySettingsViewModel.cells)
        citySettingsTableView.reloadData()
    }
    
    func configureSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
}

// MARK: - UITableViewDelegate

extension CitySettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in
            let weatherID = self.citySettingsViewModel.cells[indexPath.row].id
            self.deleteCity(weatherID: weatherID, tempType: self.tempType)
        }
        deleteAction.title = "Удалить"
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerView.delegate = self
        return footerView
    }
}

// MARK: - CitySettingsTableViewFooterDelegate

extension CitySettingsViewController: CitySettingsTableViewFooterDelegate {
    func plusButtonTapped(withButton button: UIButton) {
        showCityAddVC()
    }
    
    func change(to index: Int, withRawValue: String) {
        self.tempType = TemperatureSettings(rawValue: withRawValue) ?? .celsius
        self.footerView.tempType = tempType
        saveTemperature(temp: tempType)
        self.getLocalWeatherData(tempType: tempType)
    }
    
    func saveTemperature(temp : TemperatureSettings) {
        UserDefaults.standard.setValue(temp.rawValue, forKey: "savedTemperature")
        print(tempType.rawValue)
    }
}
