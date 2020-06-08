//
//  BigLabel.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class BigLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 100)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.4
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
