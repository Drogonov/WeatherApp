//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherDisplayLogic: class {
    func displayData(viewModel: Weather.Model.ViewModel.ViewModelData)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {

    var interactor: WeatherBusinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic)?
        
    var tempType: TemperatureSettings {
        didSet {
            print(tempType)
        }
    }
    
    private var weatherViewModel = WeatherViewModel.init(cells: [])
    
    private var weatherCollectionView = WeatherCollectionView()
    private var weatherPageView = WeatherPageView()
    private var weatherPageViewButton = WeatherPageViewButton()
      
  // MARK: Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = WeatherInteractor()
        let presenter             = WeatherPresenter()
        let router                = WeatherRouter(viewController: viewController,
                                                  dataSource: interactor,
                                                  dataDestination: interactor)
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
  
  // MARK: Routing
    
    func showCitySettingsVC(tempType: TemperatureSettings) {
        router?.showCitySettingsVC(tempType: tempType)
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
        print("viewDidLoad")
        print(tempType)
        view.backgroundColor = .orange
        interactor?.makeRequest(request: Weather.Model.Request.RequestType.getWeatherData)
        configureUI()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.configureUI()
        }
    }
    
    // MARK: - Display Data
    
    func displayData(viewModel: Weather.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeather(weatherViewModel: let weatherViewModel):
            self.weatherViewModel = weatherViewModel
            configureUI()
            print("displayWeather")
        }
    }
    
    // MARK: - ConfigureUI Functions
    
    func configureUI() {
        configureNavigationController()
        configureCollectionView()
        configurePageView()
        configurePageViewButton()
    }
        
    func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureCollectionView() {
        weatherCollectionView.delegate = self
        
        view.addSubview(weatherCollectionView)
        weatherCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                     leading: view.safeAreaLayoutGuide.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.safeAreaLayoutGuide.rightAnchor,
                                     paddingBottom: weatherPageView.pageControlHeight - 2)
        weatherCollectionView.set(weather: weatherViewModel.cells)
        weatherCollectionView.reloadData()
    }
    
    func configurePageView() {
        weatherPageView.delegate = self
        
        view.addSubview(weatherPageView)
        weatherPageView.anchor(leading: view.safeAreaLayoutGuide.leftAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               trailing: view.safeAreaLayoutGuide.rightAnchor,
                               height: weatherPageView.pageControlHeight)
        weatherPageView.set(numberOfPages: weatherViewModel.cells.count)
    }
    
    func configurePageViewButton() {
        weatherPageViewButton.delegate = self
        
        view.addSubview(weatherPageViewButton)
        weatherPageViewButton.anchor(trailing: weatherPageView.rightAnchor,
                                     paddingTrailing: 10,
                                     width: 30,
                                     height: 30)
        weatherPageViewButton.centerY(inView: weatherPageView)
    }
}

// MARK: - WeatherPageViewDelegate

extension WeatherViewController: WeatherPageViewDelegate {
    func pageChanged(sender: AnyObject, currentPage: Int) {
        let x = CGFloat(currentPage) * weatherCollectionView.frame.size.width
        weatherCollectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(weatherCollectionView.contentOffset.x / weatherCollectionView.frame.size.width)
        weatherPageView.currentPage = Int(pageNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - WeatherPageViewButtonDelegate

extension WeatherViewController: WeatherPageViewButtonDelegate {
    func showCitySettingsVC() {
        showCitySettingsVC(tempType: tempType)
    }
}
