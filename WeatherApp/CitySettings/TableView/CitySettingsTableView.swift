//
//  CitySettingsTableView.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import Foundation
import UIKit

protocol CitySettingsCellViewModel {
    var cityName: String { get }
    var temperature: String { get }
}


class CitySettingsTableView: UITableView {
    
    // MARK: - Properties
    
    var weather = [CitySettingsCellViewModel]()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        delegate = self
        dataSource = self
        
        register(CitySettingsTableViewCell.self,
                 forCellReuseIdentifier: CitySettingsTableViewCell.reuseId)
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = CitySettingsTableViewConstants.estimatedRowHeight
        sectionFooterHeight = CitySettingsTableViewConstants.sectionFooterHeight
        backgroundColor = UIColor.backgroundColorWhite()
        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func set(weather: [CitySettingsCellViewModel]) {
        self.weather = weather
        contentOffset = CGPoint.zero
        reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CitySettingsTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CitySettingsTableViewCell.reuseId, for: indexPath) as! CitySettingsTableViewCell
        cell.set(viewModel: weather[indexPath.row])
        return cell
    }
}
