//
//  DrawableView.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 09.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

protocol DrawableViewDelegate: class {
    func didDraw(stroke: [NSValue])
}

class DrawableView: UIView {
    
    weak var delegate: DrawableViewDelegate?
    
    private let path = UIBezierPath()
    private let lineWidth: CGFloat = 5.0
    private let strokeMinPointCount = 3;
    
    private var previousPoint = CGPoint.zero
    private var undoPaths = [CGPath]()
    private var currentStroke: NSMutableArray?
    
    private(set) var strokes = [NSMutableArray]()
    var isEmpty: Bool { return path.cgPath.isEmpty }

    
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.black.setStroke()
        path.stroke()
        path.lineWidth = lineWidth
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let currentPoint = touch.location(in: self)
        undoPaths.append(path.cgPath)
        path.move(to: currentPoint)
        
        currentStroke = NSMutableArray()
        currentStroke!.add(NSValue(cgPoint: currentPoint))
        
        previousPoint = currentPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let currentPoint = touch.location(in: self)
        let midPoint = self.midPoint(p0: previousPoint, p1: currentPoint)
        path.addQuadCurve(to: midPoint, controlPoint: previousPoint)
        currentStroke!.add(NSValue(cgPoint: currentPoint))

        previousPoint = currentPoint
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        strokes.append(currentStroke!)
        if (currentStroke!.count < strokeMinPointCount) {
            undo()
        } else {
            delegate?.didDraw(stroke: currentStroke as! [NSValue])
        }
    }

    private func midPoint(p0: CGPoint, p1: CGPoint) -> CGPoint {
        let x = (p0.x + p1.x) / 2
        let y = (p0.y + p1.y) / 2
        return CGPoint(x: x, y: y)
    }
    
    func undo() {
        if (undoPaths.count == 0) {
            return;
        }
        
        path.cgPath = undoPaths.popLast()!
        currentStroke = strokes.popLast()!
        previousPoint = path.currentPoint;
        
        self.setNeedsDisplay()
    }
    
    func clear() {
        path.removeAllPoints()
        undoPaths.removeAll()
        strokes.removeAll()
        currentStroke = nil

        self.setNeedsDisplay()
    }
    
}
