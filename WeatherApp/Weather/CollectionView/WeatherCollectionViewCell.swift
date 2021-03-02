//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import UIKit

protocol WeatherCellViewModel {
    var cityName: String { get }
    var temperature: String { get }
    var description: String { get }
}


class WeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "WeatherCollectionViewCell"
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42)
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.textColorWhite()
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.textColorWhite()
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42)
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor.textColorWhite()
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        addSubview(cityLabel)

        cityLabel.anchor(top: self.topAnchor,
                         leading: self.leftAnchor,
                         trailing: self.rightAnchor,
                         paddingTop: 32,
                         paddingLeading: 16,
                         paddingTrailing: 16)
        
        addSubview(weatherLabel)
        weatherLabel.anchor(top: cityLabel.bottomAnchor,
                         leading: self.leftAnchor,
                         trailing: self.rightAnchor,
                         paddingTop: 16,
                         paddingLeading: 16,
                         paddingTrailing: 16)

        addSubview(tempLabel)
        tempLabel.anchor(top: weatherLabel.bottomAnchor,
                         leading: self.leftAnchor,
                         trailing: self.rightAnchor,
                         paddingTop: 24,
                         paddingLeading: 16,
                         paddingTrailing: 16)
    }
    
    func set(viewModel: WeatherCellViewModel) {
        cityLabel.text = viewModel.cityName
        weatherLabel.text = viewModel.description
        tempLabel.text = viewModel.temperature
    }
    
    func configureEmptyCell() {
        cityLabel.text = "ДОБАВЬТЕ ГОРОД"
        weatherLabel.text = ""
        tempLabel.text = ""
    }
}
