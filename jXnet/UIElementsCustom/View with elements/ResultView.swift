//
//  ResultView.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 17.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class ResultView {
    
    var controller: ExercisesViewController!
    
    init(_ viewController: UIViewController) {
        controller = (viewController as! ExercisesViewController)
    }
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    let scoreLabelCondition = UILabel()
    let trackLayer = CAShapeLayer()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    let percentLabelCondition = UILabel()
    let shapeLayer2 = CAShapeLayer()
    
    let levelProgressView = UIProgressView(progressViewStyle: .default)
    
    func drawResult(correctAnswer: Int, countQuestion: Int, totalScore: Int) -> UIView {
        controller.title = "Результат"
        //TotalResutl
        let totalResult = UILabel(frame: CGRect(x: 20, y: controller.topbarHeight + 1, width: UIScreen.main.bounds.width - 40, height: 40))
        totalResult.text = "Результат: \(correctAnswer)/\(countQuestion)"
        totalResult.textColor = .black
        totalResult.font = UIFont.systemFont(ofSize: 27)
        totalResult.adjustsFontSizeToFitWidth = true
        totalResult.textAlignment = .center
        totalResult.minimumScaleFactor = 0.4
        controller.view.addSubview(totalResult)
        
        //ResultComment
        let resultComment = UILabel(frame: CGRect(x: 20, y: totalResult.frame.maxY + 1, width: UIScreen.main.bounds.width - 40, height: 60))
        resultComment.textColor = .black
        resultComment.font = UIFont.systemFont(ofSize: 21)
        resultComment.adjustsFontSizeToFitWidth = true
        resultComment.textAlignment = .center
        resultComment.minimumScaleFactor = 0.4
        resultComment.numberOfLines = 2
        resultComment.lineBreakMode = .byWordWrapping
        resultComment.text = "У вас определенный талант к этому!"
        controller.view.addSubview(resultComment)
        
        //Score Track
        // create my track layer
        let circularPath = UIBezierPath(arcCenter: .init(x: (UIScreen.main.bounds.width - 60) * 3 / 4 + 40, y: resultComment.frame.maxY + 40 + (UIScreen.main.bounds.width - 60) / 4), radius: (UIScreen.main.bounds.width - 60) / 4, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        controller.view.layer.addSublayer(trackLayer)
        
        scoreLabel.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 60) / 2, height: 30)
        scoreLabel.center = CGPoint(x: (UIScreen.main.bounds.width - 60) * 3 / 4 + 40, y: resultComment.frame.maxY + 35 + (UIScreen.main.bounds.width - 60) / 4)
        scoreLabel.textColor = UIColor(hexFromString: "#33CC66")
        controller.view.addSubview(scoreLabel)
        
        scoreLabelCondition.frame = CGRect(x: scoreLabel.frame.minX, y: scoreLabel.frame.maxY + 5, width: (UIScreen.main.bounds.width - 60) / 2, height: 13)
        scoreLabelCondition.textAlignment = .center
        scoreLabelCondition.textColor = .darkGray
        scoreLabelCondition.font = .systemFont(ofSize: 10)
        controller.view.addSubview(scoreLabelCondition)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(hexFromString: "#33CC66").cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        controller.view.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
        //Percent Track
        // create my track layer
        let trackLayer2 = CAShapeLayer()
        let circularPath2 = UIBezierPath(arcCenter: .init(x: (UIScreen.main.bounds.width - 60) / 4 + 20, y: resultComment.frame.maxY + 40 + (UIScreen.main.bounds.width - 60) / 4), radius: (UIScreen.main.bounds.width - 60) / 4, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer2.path = circularPath2.cgPath
        trackLayer2.strokeColor = UIColor.lightGray.cgColor
        trackLayer2.lineWidth = 5
        trackLayer2.lineCap = .round
        trackLayer2.fillColor = UIColor.clear.cgColor
        controller.view.layer.addSublayer(trackLayer2)
        
        percentLabel.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 60) / 2, height: 30)
        percentLabel.center = CGPoint(x: (UIScreen.main.bounds.width - 60) / 4 + 20, y: resultComment.frame.maxY + 35 + (UIScreen.main.bounds.width - 60) / 4)
        percentLabel.textColor = .blue
        controller.view.addSubview(percentLabel)
        
        percentLabelCondition.frame = CGRect(x: percentLabel.frame.minX, y: percentLabel.frame.maxY + 5, width: (UIScreen.main.bounds.width - 60) / 2, height: 13)
        percentLabelCondition.textAlignment = .center
        percentLabelCondition.textColor = .darkGray
        percentLabelCondition.font = .systemFont(ofSize: 10)
        controller.view.addSubview(percentLabelCondition)
        
        
        shapeLayer2.path = circularPath2.cgPath
        shapeLayer2.strokeColor = UIColor.blue.cgColor
        shapeLayer2.lineWidth = 5
        shapeLayer2.strokeEnd = 0
        shapeLayer2.lineCap = .round
        shapeLayer2.fillColor = UIColor.clear.cgColor
        controller.view.layer.addSublayer(shapeLayer2)
        
        let basicAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation2.toValue = 1
        basicAnimation2.duration = 2
        basicAnimation2.fillMode = .forwards
        basicAnimation2.isRemovedOnCompletion = false
        shapeLayer2.add(basicAnimation2, forKey: "urSoBasic")
        
        //Level label
        let levelLabel = UILabel(frame: CGRect(x: 20, y: resultComment.frame.maxY + 60 + (UIScreen.main.bounds.width - 60) / 2, width: UIScreen.main.bounds.width - 40, height: 50))
        levelLabel.text = "Уровень: 0"
        levelLabel.textColor = .black
        levelLabel.font = UIFont.systemFont(ofSize: 21)
        levelLabel.adjustsFontSizeToFitWidth = true
        levelLabel.textAlignment = .left
        levelLabel.minimumScaleFactor = 0.4
        controller.view.addSubview(levelLabel)
        
        //Current level Progress View
        let yourView = UIView(frame: CGRect(x: 20, y: levelLabel.frame.maxY + 10, width: 100, height: 20))
        yourView.backgroundColor = .green
        controller.view.addSubview(yourView)
        UIView.animate(withDuration: 2, animations: {
            yourView.frame.size.width += 400
            if (yourView.frame.size.width == 300) {yourView.frame.size.width = 0}
        }, completion: {
            (value: Bool) in
            if (yourView.superview != nil) {
                yourView.removeFromSuperview()
            }
        })
        
        //Repeat button
        let repeatButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 54, width: UIScreen.main.bounds.width, height: 54))
        repeatButton.setTitle("Попробовать еще раз", for: .normal)
        repeatButton.setTitleColor(.white, for: .normal)
        repeatButton.backgroundColor = UIColor.init(hexFromString: "#3333CC")
        repeatButton.addTarget(nil, action: #selector(repeatAction), for: .touchUpInside)
        controller.view.addSubview(repeatButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            if (self.scoreLabel.superview != nil) {
                self.scoreLabel.text = "350"
                self.scoreLabelCondition.text = "общий счёт"
                self.percentLabel.text = "100%"
                self.percentLabelCondition.text = "точность выполнения"
            }
        })
        
        return controller.view
    }
    
    @objc func repeatAction() -> Void {
        controller.initialParameters()
    }
}
