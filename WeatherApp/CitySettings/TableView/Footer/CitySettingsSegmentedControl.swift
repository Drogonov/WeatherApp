//
//  CitySettingsSegmentedControl.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import UIKit
protocol CitySettingsSegmentedControlDelegate: class {
    func change(to index: Int, withRawValue: String)
}

class CitySettingsSegmentedControl: UIView {
    
    // MARK: - Properties
    
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    private var tempType: TemperatureSettings!
    
    private var textColor: UIColor = UIColor.temperatureButtonOff()
    private var selectorTextColor: UIColor = UIColor.temperatureButtonOn()
    
    weak var delegate: CitySettingsSegmentedControlDelegate?
    
    public private(set) var selectedIndex: Int = 0
    public private(set) var selectedRawValue: String!
    
    // MARK: - Init
    
    convenience init(frame: CGRect, buttonTitle: [String], tempType: TemperatureSettings) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
        self.tempType = tempType
        
        switch tempType {
        case .celsius:
            selectedIndex = 0
        case .fahrenheit:
            selectedIndex = 1
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    private func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    private func setIndex(index: Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
    }
    
    // MARK: - Selectors
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                selectedIndex = buttonIndex
                selectedRawValue = btn.titleLabel?.text
                delegate?.change(to: selectedIndex, withRawValue: selectedRawValue)
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

// MARK: - Configure View

extension CitySettingsSegmentedControl {
    private func updateView() {
        createButton()
        configStackView()
        setIndex(index: selectedIndex)
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        addSubview(stack)
        stack.anchor(top: self.topAnchor,
                     leading: self.leftAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.rightAnchor)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 42)
            button.addTarget(self, action: #selector(CitySettingsSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}
