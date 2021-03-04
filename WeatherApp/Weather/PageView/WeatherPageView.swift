//
//  WeatherPageView.swift
//  WeatherApp
//
//  Created by Admin on 27.02.2021.
//

import Foundation
import UIKit

protocol WeatherPageViewDelegate: class {
    func pageChanged(sender: AnyObject, currentPage: Int)
}

class WeatherPageView: UIPageControl {
    
    static let pageControlHeight: CGFloat = 50
    
    weak var delegate: WeatherPageViewDelegate?

    init() {
        super.init(frame: .zero)
        currentPage = 0
        numberOfPages = 1
        pageIndicatorTintColor = UIColor.borderColor()
        currentPageIndicatorTintColor = UIColor.pageIndicatorBlack()
        backgroundColor = UIColor.backgroundColorGray()
        
        layer.borderColor = UIColor.borderColor().cgColor
        layer.borderWidth = 2
        layer.masksToBounds = false
        
        addTarget(self, action: #selector(pageChanged), for: UIControl.Event.valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pageChanged() {
        delegate?.pageChanged(sender: self, currentPage: currentPage)
    }
        
    func set(numberOfPages: Int) {
        if numberOfPages == 0 {
            self.numberOfPages = 1
        } else {
            self.numberOfPages = numberOfPages
        }
    }
    
    func setCurrentPage(page: Int) {
        currentPage = page
    }
}
