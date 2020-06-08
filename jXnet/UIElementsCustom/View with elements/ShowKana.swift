//
//  ShowKana.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class ShowKana {
    
    var controller: ExercisesViewController!
    
    init(_ viewController: UIViewController) {
        controller = (viewController as! ExercisesViewController)
    }
    
    func showKana() -> UIView {
        controller.showAsk1 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.height - controller.topbarHeight) / 3) / 2, y: controller.topbarHeight, width: (UIScreen.main.bounds.height - controller.topbarHeight) / 3, height: (UIScreen.main.bounds.height - controller.topbarHeight) / 3))
        controller.showAsk1.font = .systemFont(ofSize: 130)
        controller.view.addSubview(controller.showAsk1)

        controller.showAsk2 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.height - controller.topbarHeight) * 0.17) / 2, y: controller.showAsk1.frame.maxY, width: (UIScreen.main.bounds.height - controller.topbarHeight) * 0.17, height: (UIScreen.main.bounds.height - controller.topbarHeight) * 0.17))
        controller.showAsk2?.font = .systemFont(ofSize: 75)
        controller.showAsk2?.textAlignment = .center
        controller.view.addSubview(controller.showAsk2!)

        controller.showAnswer1 = RoundButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height - 140.0, width: 100.0, height: 100.0))
        controller.showAnswer1.layer.borderColor = UIColor.black.cgColor
        controller.showAnswer1.layer.borderWidth = 5.0
        controller.showAnswer1.setImage(UIImage(named: "arow.left"), for: .normal)
        controller.view.addSubview(controller.showAnswer1)

        controller.showAnswer2 = RoundButton(frame: CGRect(x: UIScreen.main.bounds.width - 120.0, y: UIScreen.main.bounds.height - 140.0, width: 100.0, height: 100.0))
        controller.showAnswer2.layer.borderColor = UIColor.black.cgColor
        controller.showAnswer2.layer.borderWidth = 5.0
        controller.showAnswer2.setImage(UIImage(named: "arow.right"), for: .normal)
        controller.view.addSubview(controller.showAnswer2)
        
        return controller.view
    }
}
