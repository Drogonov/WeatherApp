//
//  CityAddView.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import UIKit

protocol CityAddViewDelegate: class {
    func okButtonTapped(withButton button: UIButton)
    func rejectButtonTapped(withButton button: UIButton)
}

class CityAddView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CityAddViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Введите город"
        label.numberOfLines = 0
        label.textColor = UIColor.textColorGray()
        return label
    }()
    
    let cityNameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.clearButtonMode = .always
        tf.clearButtonMode = .whileEditing
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = UIColor.textColorGray()
        tf.keyboardAppearance = .dark
        tf.attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return tf
    }()
    
    let separator: UIView = {
        let sr = UIView()
        sr.backgroundColor = UIColor.borderColor()
        return sr
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ок", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let rejectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
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
        delegate?.okButtonTapped(withButton: okButton)
    }
    
    @objc func rejectButtonTapped() {
        delegate?.rejectButtonTapped(withButton: rejectButton)
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        
        addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor,
                          leading: self.leftAnchor,
                          paddingTop: 8,
                          paddingLeading: 8)
        
        addSubview(cityNameTextField)
        cityNameTextField.anchor(top: titleLabel.bottomAnchor,
                                 leading: self.leftAnchor,
                                 trailing: self.rightAnchor,
                                 paddingTop: 8,
                                 paddingLeading: 16,
                                 paddingTrailing: 16,
                                 height: 50)
        
        addSubview(separator)
        separator.anchor(top: cityNameTextField.bottomAnchor,
                         leading: self.leftAnchor,
                         trailing: self.rightAnchor,
                         height: 1)
        
        addSubview(okButton)
        okButton.anchor(top: separator.bottomAnchor,
                        leading: self.leftAnchor,
                        paddingLeading: (self.frame.width / 2) + 100,
                        paddingBottom: 8,
                        width: 100,
                        height: 50)
        
        addSubview(rejectButton)
        rejectButton.anchor(top: separator.bottomAnchor,
                            trailing: self.rightAnchor,
                            paddingBottom: 8,
                            paddingTrailing: (self.frame.width / 2) + 100,
                            width: 100,
                            height: 50)
        
    }
    
}
