//
//  WeatherCollectionView.swift
//  WeatherApp
//
//  Created by Admin on 04.03.2021.
//

import Foundation
import UIKit

protocol WeatherCollectionViewDelegate: class {
    func scrollToPage(page: Int)
}

class WeatherCollectionView: UIView {

    // MARK: - Properties
    
    private var weather = [WeatherCellViewModel]()
    weak var delegate: WeatherCollectionViewDelegate?
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherCollectionViewCell.self,
                 forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseId)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.backgroundColorGray()
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.layer.borderColor = UIColor.borderColor().cgColor
        collectionView.layer.borderWidth = 2
        collectionView.layer.masksToBounds = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI Functions
    
    private func configureUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        collectionView.anchor(top: self.topAnchor,
                              leading: self.leftAnchor,
                              bottom: self.bottomAnchor,
                              trailing: self.rightAnchor)
    }
    
    func set(weather: [WeatherCellViewModel]) {
        self.weather = weather
        collectionView.contentOffset = CGPoint.zero
        collectionView.reloadData()
        print("set")
    }
    
    func setContentOffset(page: Int) {
        let x = CGFloat(page) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(collectionView.contentOffset.x / collectionView.frame.size.width)
        delegate?.scrollToPage(page: Int(pageNumber))
    }
    
}

extension WeatherCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if weather.isEmpty {
            return 1
        }
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseId, for: indexPath) as! WeatherCollectionViewCell
        if weather.isEmpty {
            cell.configureEmptyCell()
        } else {
            cell.set(viewModel: weather[indexPath.row])
        }
        return cell
    }
}

extension WeatherCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
