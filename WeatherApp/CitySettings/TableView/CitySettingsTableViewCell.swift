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
        label.font = CitySettingsTableViewConstants.cityLabelFont
        label.textAlignment = .left
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.textColorWhite()
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = CitySettingsTableViewConstants.tempLabelFont
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
        layer.borderWidth = CitySettingsTableViewConstants.borderWidth
        layer.masksToBounds = false
        
        contentView.addSubview(cityLabel)
        cityLabel.anchor(top: contentView.topAnchor,
                         leading: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.rightAnchor,
                         paddingTop: CitySettingsTableViewConstants.cityLabelPadding,
                         paddingLeading: CitySettingsTableViewConstants.cityLabelPadding,
                         paddingBottom: CitySettingsTableViewConstants.cityLabelPadding,
                         paddingTrailing: tempLabel.frame.width + CitySettingsTableViewConstants.cityLabelPadding * 2)


        contentView.addSubview(tempLabel)
        tempLabel.anchor(top: contentView.topAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.rightAnchor,
                         paddingTop: CitySettingsTableViewConstants.tempLabelPadding,
                         paddingBottom: CitySettingsTableViewConstants.tempLabelPadding,
                         paddingTrailing: CitySettingsTableViewConstants.tempLabelPadding)
        
    }
        
    func set(viewModel: CitySettingsCellViewModel) {
        cityLabel.text = viewModel.cityName
        tempLabel.text = viewModel.temperature
    }
}
