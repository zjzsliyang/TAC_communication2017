//
//  GraphView.swift
//  II-Graph Calculator
//
//  Created by LRui on 16/8/11.
//  Copyright © 2016年 lirui. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    var color = UIColor ( red: 0.1882, green: 0.3765, blue: 1.0, alpha: 1.0 )
    
    var height: CGFloat {
        return self.frame.height
    }
    
    var width: CGFloat {
        return self.frame.width
    }
    
    var yData = [Double]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    fileprivate func drawAxis() -> UIBezierPath {
        let path = UIBezierPath()
//        x轴
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addLine(to: CGPoint(x: width, y: height / 2))
        path.addLine(to: CGPoint(x: width - 10, y: height / 2 - 10))
        path.move(to: CGPoint(x: width, y: height / 2))
        path.addLine(to: CGPoint(x: width - 10, y: height / 2 + 10))
        for i in 1...50 {
            path.move(to: CGPoint(x: CGFloat(i) * width / 50, y: height / 2))
            path.addLine(to: CGPoint(x: CGFloat(i) * width / 50, y: height / 2 - 5))
        }
//        y轴
        path.move(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width / 2 - 10, y: 10))
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width / 2 + 10, y: 10))
        for i in 1...50 {
            path.move(to: CGPoint(x: width / 2, y: CGFloat(i) * height / 50))
            path.addLine(to: CGPoint(x: width / 2 + 5, y: CGFloat(i) * height / 50))
        }
        
        return path
    }
    
    fileprivate func drawExperssion() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: height / 2 - CGFloat(yData[0]) * height / 100))
        for i in 1..<1000 {
            path.addLine(to: CGPoint(x: CGFloat(i) * width / 1000, y: height / 2 - CGFloat(yData[i]) * height / 100))
        }
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.setStroke()
        drawAxis().stroke()
        
        if yData.count != 0 {
            drawExperssion().stroke()
        }
    }

}
