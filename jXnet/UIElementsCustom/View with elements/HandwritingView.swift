//
//  HandwritingView.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 09.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class HandwritingView {
    
    var controller: ExercisesViewController!
    
    init(_ viewController: UIViewController) {
        controller = (viewController as! ExercisesViewController)
    }
    
    func drawStandartSheet() -> UIView {
        
        var lineH: UIView!
        var lineV: UIView!
        var lineT: UIView!
        
        controller.showAsk1 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 60.0) / 2) / 2, y: controller.topbarHeight + 20, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk1)
        
        controller.drawableView = DrawableView(frame: CGRect(x: 0, y: controller.showAsk1.frame.maxY + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20 - controller.showAsk1.frame.maxY - UIScreen.main.bounds.height / 10))
        controller.drawableView.backgroundColor = .white
        controller.view.addSubview(controller.drawableView)
        
        lineH = UIView(frame: CGRect(x: 0, y: controller.drawableView.frame.midY - 2.5, width: UIScreen.main.bounds.width, height: 5))
        lineH.backgroundColor = UIColor(white: 0.95, alpha: 0.4)
        controller.view.addSubview(lineH)
        
        lineV = UIView(frame: CGRect(x: controller.drawableView.frame.midX - 2.5, y: controller.drawableView.frame.minY, width: 5, height: controller.drawableView.frame.size.height))
        lineV.backgroundColor = UIColor(white: 0.95, alpha: 0.4)
        controller.view.addSubview(lineV)
        
        lineT = UIView(frame: CGRect(x: 0, y: controller.drawableView.frame.minY, width: UIScreen.main.bounds.width, height: 5))
        lineT.backgroundColor = .lightGray
        controller.view.addSubview(lineT)
        
        controller.showAnswer1 = UIButton(frame: CGRect(x: 0, y: controller.drawableView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10))
        controller.showAnswer1.backgroundColor = UIColor(hexFromString: "#FF3300")
        controller.showAnswer1.setTitleColor(.white, for: .normal)
        controller.showAnswer1.titleLabel?.textAlignment = .center
        controller.showAnswer1.titleLabel?.font = .systemFont(ofSize: (23 * UIScreen.main.bounds.height) / 896)
        controller.showAnswer1.titleLabel?.adjustsFontSizeToFitWidth = true
        controller.showAnswer1.titleLabel?.minimumScaleFactor = 0.4
        controller.showAnswer1.setTitle("Проверить", for: .normal)
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = UIButton(frame: CGRect(x: controller.drawableView.frame.maxX - 55, y: controller.drawableView.frame.midY + 5, width: 50, height: 50))
        controller.showAnswer2.setImage(UIImage(named: "clear"), for: .normal)
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = UIButton(frame: CGRect(x: controller.drawableView.frame.maxX - 55, y: controller.drawableView.frame.midY + 85, width: 50, height: 50))
        controller.showAnswer3?.setImage(UIImage(named: "cancel"), for: .normal)
        controller.view.addSubview(controller.showAnswer3!)
        
        return controller.view
    }
    
    func drawStandartSheetWithStencil() -> UIView {
        
        var lineH: UIView!
        var lineV: UIView!
        var lineT: UIView!
        
        controller.showAsk1 = BigLabel(frame: CGRect(x: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 60.0) / 2) / 2, y: controller.topbarHeight + 20, width: (UIScreen.main.bounds.width - 60.0) / 2, height: (UIScreen.main.bounds.width - 60.0) / 2))
        controller.view.addSubview(controller.showAsk1)
        
        controller.drawableView = DrawableView(frame: CGRect(x: 0, y: controller.showAsk1.frame.maxY + 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20 - controller.showAsk1.frame.maxY - UIScreen.main.bounds.height / 10))
        controller.drawableView.backgroundColor = .white
        controller.view.addSubview(controller.drawableView)
        
        controller.showAsk2 = BigLabel(frame: CGRect(x: 0, y: controller.drawableView.frame.minY, width: UIScreen.main.bounds.width, height: controller.drawableView.frame.height))
        controller.showAsk2?.font = .systemFont(ofSize: 200)
        controller.showAsk2?.textAlignment = .center
        controller.showAsk2?.textColor = UIColor(white: 0.95, alpha: 0.5)
        controller.view.addSubview(controller.showAsk2!)
        
        lineH = UIView(frame: CGRect(x: 0, y: controller.drawableView.frame.midY - 2.5, width: UIScreen.main.bounds.width, height: 5))
        lineH.backgroundColor = UIColor(white: 0.95, alpha: 0.4)
        controller.view.addSubview(lineH)
        
        lineV = UIView(frame: CGRect(x: controller.drawableView.frame.midX - 2.5, y: controller.drawableView.frame.minY, width: 5, height: controller.drawableView.frame.size.height))
        lineV.backgroundColor = UIColor(white: 0.95, alpha: 0.4)
        controller.view.addSubview(lineV)
        
        lineT = UIView(frame: CGRect(x: 0, y: controller.drawableView.frame.minY, width: UIScreen.main.bounds.width, height: 5))
        lineT.backgroundColor = .lightGray
        controller.view.addSubview(lineT)
        
        controller.showAnswer1 = UIButton(frame: CGRect(x: 0, y: controller.drawableView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10))
        controller.showAnswer1.backgroundColor = UIColor(hexFromString: "#FF3300")
        controller.showAnswer1.setTitleColor(.white, for: .normal)
        controller.showAnswer1.titleLabel?.textAlignment = .center
        controller.showAnswer1.titleLabel?.font = .systemFont(ofSize: (23 * UIScreen.main.bounds.height) / 896)
        controller.showAnswer1.titleLabel?.adjustsFontSizeToFitWidth = true
        controller.showAnswer1.titleLabel?.minimumScaleFactor = 0.4
        controller.showAnswer1.setTitle("Далее", for: .normal)
        controller.view.addSubview(controller.showAnswer1)
        
        controller.showAnswer2 = UIButton(frame: CGRect(x: controller.drawableView.frame.maxX - 55, y: controller.drawableView.frame.midY + 5, width: 50, height: 50))
        controller.showAnswer2.setImage(UIImage(named: "clear"), for: .normal)
        controller.view.addSubview(controller.showAnswer2)
        
        controller.showAnswer3 = UIButton(frame: CGRect(x: controller.drawableView.frame.maxX - 55, y: controller.drawableView.frame.midY + 85, width: 50, height: 50))
        controller.showAnswer3?.setImage(UIImage(named: "cancel"), for: .normal)
        controller.view.addSubview(controller.showAnswer3!)
        
        return controller.view
    }
}

