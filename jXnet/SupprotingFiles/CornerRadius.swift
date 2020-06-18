//
//  CornerRadius.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 19.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
