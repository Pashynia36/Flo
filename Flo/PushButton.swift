//
//  PushButton.swift
//  Flo
//
//  Created by Pavlo Novak on 4/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
//@IBDesignable

class PushButton: UIButton {
    
    private struct Constants {
        
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        
        return bounds.height / 2
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        
        // setting up oval(circle) for our button
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        // setting up strokes for horizontal line
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        let halfPlusHeight: CGFloat = plusWidth / 2
        //create a bezierPath with specific lineWidth
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        // horizontal line of plus
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth + Constants.halfPointShift, y: halfHeight + Constants.halfPointShift))
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth + Constants.halfPointShift, y: halfHeight + Constants.halfPointShift))
        // vertical line of plus
        if isAddButton {
            plusPath.move(to: CGPoint(x: halfWidth + Constants.halfPointShift, y: halfHeight - halfPlusHeight + Constants.halfPointShift))
            plusPath.addLine(to: CGPoint(x: halfWidth + Constants.halfPointShift, y: halfHeight + halfPlusHeight + Constants.halfPointShift))
        }
        // setting color and stroke
        UIColor.white.setStroke()
        plusPath.stroke()
    }
}
