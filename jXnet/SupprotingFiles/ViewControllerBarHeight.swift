//
//  NavBarHeight.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var topbarHeight: CGFloat {
        return (self.navigationController?.navigationBar.frame.height ?? 0.0) + UIApplication.shared.statusBarFrame.size.height
    }
    
    var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
}
