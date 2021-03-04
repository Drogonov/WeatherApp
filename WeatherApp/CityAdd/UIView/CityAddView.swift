//
//  CityAddView.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import UIKit

protocol CityAddViewDelegate: class {
    func okButtonTapped(withCityName cityName: String)
    func rejectButtonTapped()
}

class CityAddView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CityAddViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = CityAddViewConstants.titleLabelFont
        label.textAlignment = .center
        label.text = "Введите город"
        label.numberOfLines = 0
        label.textColor = UIColor.textColorGray()
        return label
    }()
    
    private let cityNameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.clearButtonMode = .always
        tf.clearButtonMode = .whileEditing
        tf.font = CityAddViewConstants.cityNameTextFieldFont
        tf.textColor = UIColor.textColorGray()
        tf.attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return tf
    }()
    
    private let separator: UIView = {
        let sr = UIView()
        sr.backgroundColor = UIColor.borderColor()
        return sr
    }()
    
    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ок", for: .normal)
        button.titleLabel?.font = CityAddViewConstants.buttonFont
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let rejectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = CityAddViewConstants.buttonFont
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func okButtonTapped() {
        guard let cityName = cityNameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        delegate?.okButtonTapped(withCityName: cityName)
    }
    
    @objc func rejectButtonTapped() {
        delegate?.rejectButtonTapped()
    }
    
    // MARK: - ConfigureUI Functions
    
    private func configureUI() {
                
        addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor,
                          leading: self.leftAnchor,
                          paddingTop: CityAddViewConstants.titleLabelPadding,
                          paddingLeading: CityAddViewConstants.titleLabelPadding)
        
        addSubview(cityNameTextField)
        cityNameTextField.anchor(top: titleLabel.bottomAnchor,
                                 leading: self.leftAnchor,
                                 trailing: self.rightAnchor,
                                 paddingTop: CityAddViewConstants.cityNameTextFieldPaddingTop,
                                 paddingLeading: CityAddViewConstants.cityNameTextFieldPadding,
                                 paddingTrailing: CityAddViewConstants.cityNameTextFieldPadding,
                                 height: CityAddViewConstants.cityNameTextFieldHeight)
        
        addSubview(separator)
        separator.anchor(top: cityNameTextField.bottomAnchor,
                         leading: self.leftAnchor,
                         trailing: self.rightAnchor,
                         height: CityAddViewConstants.separatorHeight)
        
        let stackView = UIStackView(arrangedSubviews: [okButton, rejectButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = CityAddViewConstants.stackViewSpasing
        
        addSubview(stackView)
        stackView.anchor(top: separator.bottomAnchor,
                         paddingTop: CityAddViewConstants.stackViewPadding,
                         size: CityAddViewConstants.stackViewSize)
        stackView.centerX(inView: self)
    }
}
