//
//  UIImage+Alpha.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 21.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

// UIImage+Alpha.swift

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
