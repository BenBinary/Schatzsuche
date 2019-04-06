//
//  ArrowView.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 19.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit

@IBDesignable class ArrowView: UIView {

  
    @IBInspectable var color:UIColor = .black
    
    @IBInspectable var heading: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let rad = heading / 180.0 * .pi
        let side = min(frame.size.width, frame.size.height)
        let side2 = side/2              // halbe Seitenlänge
        let radius1 = side2 * 0.95      // Radius außen
        let radius2 = side2 * 0.25      // Radius innen
        let x0 = frame.size.width / 2  // Mittelpunkt
        let y0 = frame.size.height / 2
        
        
        let x1 = x0 + radius1 * CGFloat(cos(rad))
        let y1 = y0 - radius1 * CGFloat(sin(rad))
        
        let x2 = x0 + radius1 * CGFloat(cos(rad + .pi * 0.8))
        let y2 = x0 + radius1 * CGFloat(sin(rad + .pi * 0.8))
        
        let x3 = x0 + radius2 * CGFloat(cos(rad + .pi))
        let y3 = y0 - radius2 * CGFloat(sin(rad + .pi))
        
        let x4 = x0 + radius1 * CGFloat(cos(rad + .pi * 1.2))
        let y4 = y0 + radius1 * CGFloat(sin(rad + .pi * 1.2))
        
        
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: x1, y: y1))
        myBezier.addLine(to: CGPoint(x: x2, y: y2))
        myBezier.addLine(to: CGPoint(x: x3, y: y4))
        myBezier.addLine(to: CGPoint(x: x4, y: y4))
        
        myBezier.close()
        color.setFill()
        myBezier.fill()
        color.setStroke()
        myBezier.stroke()
        
    }

}
