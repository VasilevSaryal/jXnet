//
//  BigShadowButton.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class BigShadowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.height / 4
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.init(hexFromString: "#CCCCCC").cgColor
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30.0)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.4
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.init(hexFromString: "#CCCCCC").cgColor
        //backgroundColor = .white
        setTitleColor(.red, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30.0)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.4
    }

}
