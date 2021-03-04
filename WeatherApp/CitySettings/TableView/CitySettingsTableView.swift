//
//  CitySettingsTableView.swift
//  WeatherApp
//
//  Created by Admin on 04.03.2021.
//

import Foundation
import UIKit

protocol CitySettingsCellViewModel {
    var cityName: String { get }
    var temperature: String { get }
}

protocol CitySettingsTableViewDelegate: class {
    func deleteCity(weatherID: Int, tempType: TemperatureSettings)
    func plusButtonTapped()
    func changeTempType(changedTempType: TemperatureSettings)
    func refresh(_ sender: AnyObject)
}

class CitySettingsTableView: UIView {

    // MARK: - Properties
    
    private var tempType: TemperatureSettings
    private var viewModel = CitySettingsViewModel.init(cells: [])
    private var weather = [CitySettingsCellViewModel]()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private lazy var footerView = CitySettingsTableViewFooter(frame: .zero, tempType: tempType)
    private var refreshControl = UIRefreshControl()
    
    weak var delegate: CitySettingsTableViewDelegate?
    
    
    init(frame: CGRect, tempType: TemperatureSettings) {
        self.tempType = tempType
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI Functions
    
    private func configureUI() {
        configureTableView()
        configureFooterView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CitySettingsTableViewCell.self,
                 forCellReuseIdentifier: CitySettingsTableViewCell.reuseId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CitySettingsTableViewConstants.estimatedRowHeight
        tableView.sectionFooterHeight = CitySettingsTableViewConstants.sectionFooterHeight
        tableView.backgroundColor = UIColor.backgroundColorWhite()
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)

        
        addSubview(tableView)
        tableView.anchor(top: self.topAnchor,
                         leading: self.leftAnchor,
                         bottom: self.bottomAnchor,
                         trailing: self.rightAnchor)
    }
    
    private func configureFooterView() {
        footerView.delegate = self
        footerView.set(tempType: tempType)
    }
    
    func set(viewModel: CitySettingsViewModel) {
        self.viewModel = viewModel
        self.weather = viewModel.cells
        tableView.contentOffset = CGPoint.zero
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func refresh(_ sender: AnyObject) {
        delegate?.refresh(sender)
    }
        
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CitySettingsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitySettingsTableViewCell.reuseId, for: indexPath) as! CitySettingsTableViewCell
        cell.set(viewModel: weather[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in
            let weatherID = self.viewModel.cells[indexPath.row].id
            print("DEBUG: CitySettingsViewController weatherID to delete \(weatherID)")
            self.delegate?.deleteCity(weatherID: weatherID, tempType: self.tempType)
        }
        deleteAction.title = "Удалить"
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
}

// MARK: - CitySettingsTableViewFooterDelegate

extension CitySettingsTableView: CitySettingsTableViewFooterDelegate {
    func plusButtonTapped(withButton button: UIButton) {
        delegate?.plusButtonTapped()
    }
    
    func change(to index: Int, withRawValue: String) {
        self.tempType = TemperatureSettings(rawValue: withRawValue) ?? .celsius
        self.footerView.set(tempType: tempType)
        delegate?.changeTempType(changedTempType: tempType)
    }
}
