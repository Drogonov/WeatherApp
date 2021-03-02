//
//  WeatherCollectionView.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import Foundation
import UIKit

class WeatherCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    var weather = [WeatherCellViewModel]()
    
    // MARK: - Init
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(WeatherCollectionViewCell.self,
                 forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseId)
        isPagingEnabled = true
        backgroundColor = UIColor.backgroundColorGray()
        showsHorizontalScrollIndicator = false

        layer.borderColor = UIColor.borderColor().cgColor
        layer.borderWidth = 2
        layer.masksToBounds = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func set(weather: [WeatherCellViewModel]) {
        self.weather = weather
        contentOffset = CGPoint.zero
        reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WeatherCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if weather.isEmpty {
            return 1
        }
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseId, for: indexPath) as! WeatherCollectionViewCell
        if weather.isEmpty {
            cell.configureEmptyCell()
        } else {
            cell.set(viewModel: weather[indexPath.row])
        }
        return cell
    }
}
