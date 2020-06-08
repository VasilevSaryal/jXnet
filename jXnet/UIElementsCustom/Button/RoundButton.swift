//
//  RoundButton.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = .systemFont(ofSize: 35.0)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.4
        self.layer.cornerRadius = frame.size.height / 2
        self.layer.borderWidth = 1.0
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        self.titleLabel?.font = .systemFont(ofSize: 35.0)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.4
        self.layer.cornerRadius = frame.size.height / 2
        self.layer.borderWidth = 1.0
    }

}
