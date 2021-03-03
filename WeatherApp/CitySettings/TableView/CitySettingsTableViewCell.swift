//
//  CitySettingsTableViewCell.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import UIKit

class CitySettingsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "CitySettingsTableViewCell"
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .left
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.textColorWhite()
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42)
        label.textAlignment = .right
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.textColorWhite()
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        backgroundColor = UIColor.backgroundColorGray()
        
        layer.borderColor = UIColor.borderColor().cgColor
        layer.borderWidth = 1
        layer.masksToBounds = false
        
        contentView.addSubview(cityLabel)
        cityLabel.anchor(top: contentView.topAnchor,
                         leading: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.rightAnchor,
                         paddingTop: 8,
                         paddingLeading: 8,
                         paddingBottom: 8,
                         paddingTrailing: tempLabel.frame.width + 16)


        contentView.addSubview(tempLabel)
        tempLabel.anchor(top: contentView.topAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.rightAnchor,
                         paddingTop: 8,
                         paddingBottom: 8,
                         paddingTrailing: 8)
        
    }
        
    func set(viewModel: CitySettingsCellViewModel) {
        cityLabel.text = viewModel.cityName
        tempLabel.text = viewModel.temperature
    }
}
