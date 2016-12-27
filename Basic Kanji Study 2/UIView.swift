//
//  UIView.swift
//  Motor
//
//  Created by Davide Mendolia on 30/11/15.
//  Copyright © 2015 Schibsted. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func resetCorners() {
        self.layer.mask = nil
    }
}
