//
//  CitySettingsTableViewFooter.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import UIKit

protocol CitySettingsTableViewFooterDelegate: class {
    func plusButtonTapped(withButton button: UIButton)
    func change(to index: Int, withRawValue: String)
}

class CitySettingsTableViewFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CitySettingsTableViewFooterDelegate?
    
    private let celsiusButtonTitle = TemperatureSettingsValues.celsiusRawValue
    private let fahrenheitButtonTitle = TemperatureSettingsValues.fahrenheitRawValue
    
    private var tempType: TemperatureSettings
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let segmentControlFrame = CGRect(x: 0, y: 0, width: 120, height: 80)
    private lazy var segmentControl = CitySettingsSegmentedControl(frame: segmentControlFrame, buttonTitle: [celsiusButtonTitle, fahrenheitButtonTitle], tempType: tempType)
        
    
    // MARK: - Init
    
    init(frame: CGRect, tempType: TemperatureSettings) {
        self.tempType = tempType
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    @objc func plusButtonTapped() {
        delegate?.plusButtonTapped(withButton: plusButton)
    }
    
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        segmentControl.delegate = self
        
        addSubview(segmentControl)
        segmentControl.centerY(inView: self)
        segmentControl.anchor(leading: self.leftAnchor,
                              paddingLeading: 8,
                              width: 120,
                              height: 80)
        
        
        addSubview(plusButton)
        plusButton.centerY(inView: self)
        plusButton.anchor(trailing: self.rightAnchor,
                          paddingTrailing: 20,
                          width: 40,
                          height: 40)
    }
    
    func set(tempType: TemperatureSettings) {
        self.tempType = tempType
    }
    
}

// MARK: - CitySettingsSegmentedControlDelegate

extension CitySettingsTableViewFooter: CitySettingsSegmentedControlDelegate {
    func change(to index: Int, withRawValue: String) {
        delegate?.change(to: index, withRawValue: withRawValue)
    }
}
