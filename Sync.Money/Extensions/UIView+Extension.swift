//
//  UIView+RoundCorners.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 09/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

extension UIView {
    
    /// It rounds the corners of the view that are passed as parameters
    ///
    /// - Parameter cornerRadius: the radius to use when drawing the rounded corners
    /// - Parameter corners: corners of the view to be rounded
    func roundCorners(cornerRadius: Double, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    /// It sets a gradient to the background of the view
    ///
    /// - Parameter topColor: color at the top of the view
    /// - Parameter bottomColor: color at the bottom of the view
    func setGradientBackground(with topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        gradientLayer.cornerRadius = 10
        
        layer.insertSublayer(gradientLayer, at:0)
    }
}
