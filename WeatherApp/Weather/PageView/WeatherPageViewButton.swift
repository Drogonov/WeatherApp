//
//  WeatherPageViewButton.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import Foundation
import UIKit

protocol WeatherPageViewButtonDelegate: class {
    func showCitySettingsVC()
}

class WeatherPageViewButton: UIButton {
    
    weak var delegate: WeatherPageViewButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        setImage(UIImage(systemName: "list.star"), for: .normal)
        backgroundColor = UIColor.temperatureButtonOn()
        tintColor = UIColor.backgroundColorGray()
        layer.cornerRadius = 3
        addTarget(self, action: #selector(showCitySettingsVC), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showCitySettingsVC() {
        delegate?.showCitySettingsVC()
    }
}
