//
//  ChooseCorrectAnswer.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class ChooseCorrectAnswer {
    
    var controller: ExercisesViewController!
    
    init(_ viewController: UIViewController) {
        controller = (viewController as! ExercisesViewController)
    }
    
    func drawYesNo() -> UIView {
        controller.showAsk1 = BigLabel(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height / 2 - (UIScreen.main.bounds.width - 60.0) / 2 - 20.0, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk1)

        controller.showAsk2 = BigLabel(frame: CGRect(x: 40.0 + (UIScreen.main.bounds.width - 60.0) / 2, y: UIScreen.main.bounds.height / 2 - (UIScreen.main.bounds.width - 60.0) / 2 - 20.0, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk2!)

        controller.showAnswer1 = RoundButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height - 170.0, width: 100.0, height: 100.0))
        controller.showAnswer1.layer.borderColor = UIColor.red.cgColor
        controller.showAnswer1.setTitleColor(.red, for: .normal)
        controller.showAnswer1.setTitle("нет", for: .normal)
        controller.view.addSubview(controller.showAnswer1)

        controller.showAnswer2 = RoundButton(frame: CGRect(x: UIScreen.main.bounds.width - 120.0, y: UIScreen.main.bounds.height - 170.0, width: 100.0, height: 100.0))
        controller.showAnswer2.setTitleColor(UIColor.init(hexFromString: "#33CC66"), for: .normal)
        controller.showAnswer2.layer.borderColor = UIColor.init(hexFromString: "#33CC66").cgColor
        controller.showAnswer2.setTitle("да", for: .normal)
        controller.view.addSubview(controller.showAnswer2)
        
        return controller.view
    }
    
    func drawFourAnswer() -> UIView {
        controller.showAsk1 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 60.0) / 2) / 2, y: UIScreen.main.bounds.height / 2 - (UIScreen.main.bounds.width - 60.0) / 2 - 20.0, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk1)
        
        controller.showAnswer1 = BigShadowButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 2))
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 2))
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = BigShadowButton(frame: CGRect(x: 20, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 2 + 60, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 2))
        controller.view.addSubview(controller.showAnswer3!)
        
        controller.showAnswer4 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 2 + 60, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 2))
        controller.view.addSubview(controller.showAnswer4!)
        
        return controller.view
    }
    
    func drawSixAnswer() -> UIView{
        controller.showAsk1 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 60.0) / 2) / 2, y: UIScreen.main.bounds.height / 2 - (UIScreen.main.bounds.width - 60.0) / 2 - 20.0, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk1)
        
        controller.showAnswer1 = BigShadowButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = BigShadowButton(frame: CGRect(x: 20, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 + 40, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer3!)
        
        controller.showAnswer4 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 + 40, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer4!)
        
        controller.showAnswer5 = BigShadowButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 * 2 + 60, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer5!)
        
        controller.showAnswer6 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 * 2 + 60, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer6!)
        
        return controller.view
    }
    
    func drawNineAnswer() -> UIView{
        controller.showAsk1 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 60.0) / 2) / 2, y: UIScreen.main.bounds.height / 2 - (UIScreen.main.bounds.width - 60.0) / 2 - 20.0, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk1)
        
        controller.showAnswer1 = BigShadowButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 3 + 40.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 3 * 2 + 60.0, y: UIScreen.main.bounds.height / 2 + 20, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer3!)
        
        controller.showAnswer4 = BigShadowButton(frame: CGRect(x: 20, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 + 40, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer4!)
        
        controller.showAnswer5 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 3 + 40.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 + 40, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer5!)
        
        controller.showAnswer6 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 3 * 2 + 60.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 + 40, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer6!)
        
        controller.showAnswer7 = BigShadowButton(frame: CGRect(x: 20.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 * 2 + 60, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer7!)
        
        controller.showAnswer8 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 3 + 40.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 * 2 + 60, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer8!)
        
        controller.showAnswer9 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 3 * 2 + 60.0, y: UIScreen.main.bounds.height / 2 + (UIScreen.main.bounds.height / 2 - 80) / 3 * 2 + 60, width: (UIScreen.main.bounds.width - 80) / 3, height: (UIScreen.main.bounds.height / 2 - 80) / 3))
        controller.view.addSubview(controller.showAnswer9!)
        
        return controller.view
    }
}
