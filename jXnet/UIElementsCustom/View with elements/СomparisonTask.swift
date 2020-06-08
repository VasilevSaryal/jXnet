//
//  СomparisonTask.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 09.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class ComparsionTask {
    
    var controller: ExercisesViewController!
    
    init(_ viewController: UIViewController) {
        controller = (viewController as! ExercisesViewController)
    }
    
    func drawComparsionFive() -> UIView{
  
        controller.showAnswer1 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.topbarHeight + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.topbarHeight + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer1.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer3!)
        
        controller.showAnswer4 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer2.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer4!)
        
        controller.showAnswer5 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer3!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer5!)
        
        controller.showAnswer6 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer4!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer6!)
        
        controller.showAnswer7 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer5!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer7!)
        
        controller.showAnswer8 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer6!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer8!)
        
        controller.showAnswer9 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer7!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer9!)
        
        controller.showAnswer10 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer8!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 120) / 5))
        controller.view.addSubview(controller.showAnswer10!)
        
        
        return controller.view
    }
    
    func drawComparsionSix() -> UIView{
        
        controller.showAnswer1 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.topbarHeight + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.topbarHeight + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer1.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer3!)
        
        controller.showAnswer4 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer2.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer4!)
        
        controller.showAnswer5 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer3!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer5!)
        
        controller.showAnswer6 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer4!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer6!)
        
        controller.showAnswer7 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer5!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer7!)
        
        controller.showAnswer8 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer6!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer8!)
        
        controller.showAnswer9 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer7!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer9!)
        
        controller.showAnswer10 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer8!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer10!)
        
        controller.showAnswer11 = BigShadowButton(frame: CGRect(x: 20.0, y: controller.showAnswer9!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer11!)
        
        controller.showAnswer12 = BigShadowButton(frame: CGRect(x: (UIScreen.main.bounds.width - 80) / 2 + 60.0, y: controller.showAnswer10!.frame.maxY + 20, width: (UIScreen.main.bounds.width - 80) / 2, height: (UIScreen.main.bounds.height - controller.topbarHeight - 140) / 6))
        controller.view.addSubview(controller.showAnswer12!)
        
        return controller.view
    }
}
