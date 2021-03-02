//
//  Extensions.swift
//  WeatherApp
//
//  Created by Admin on 26.02.2021.
//

import UIKit

// MARK: - UIView

extension UIView {
        
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets? = nil,
                paddingTop: CGFloat = 0,
                paddingLeading: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingTrailing: CGFloat = 0,
                size: CGSize? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leftAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            rightAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fillSuperview(padding: UIEdgeInsets) {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor,
               padding: padding)
    }

    func fillSuperview() {
        fillSuperview(padding: .zero)
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView,
                 leadingAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeading: CGFloat = 0,
                 constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                 constant: constant).isActive = true
        
        if let leading = leadingAnchor {
            anchor(leading: leading,
                   paddingLeading: paddingLeading)
        }
    }
    
    func setDimensions(height: CGFloat,
                       width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}


// MARK: - UIColor

extension UIColor {
    
    static func textColorWhite() -> UIColor {
        return UIColor.white
    }
    
    static func textColorGray() -> UIColor {
        return UIColor.gray
    }
    
    static func backgroundColorWhite() -> UIColor {
        return UIColor.white
    }
    
    static func backgroundColorGray() -> UIColor {
        return UIColor.lightGray
    }
    
    static func borderColor() -> UIColor {
        return UIColor.darkGray
    }
    
    static func temperatureButtonOn() -> UIColor {
        return UIColor.darkGray
    }
    
    static func temperatureButtonOff() -> UIColor {
        return UIColor.lightGray
    }
    
    static func pageIndicatorBlack() -> UIColor {
        return UIColor.black
    }
}

// MARK: - UIViewController

extension UIViewController {
    func showNotification(title: String, message: String? = nil, defaultAction: Bool? = nil, defaultActionText: String? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        if defaultAction == true {
            alert.addAction(UIAlertAction(title: defaultActionText, style: .default, handler: { (_) in
                alert.dismiss(animated: true)
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
