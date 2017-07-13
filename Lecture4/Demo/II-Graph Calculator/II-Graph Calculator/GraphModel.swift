//
//  GraphModel.swift
//  II-Graph Calculator
//
//  Created by LRui on 16/8/12.
//  Copyright © 2016年 lirui. All rights reserved.
//

import Foundation

class GraphModel {
    var expression: String?
    
    fileprivate let calculatorDictionary: Dictionary<String, (Double) -> Double> = [
        "sin": {sin($0)},
        "cos": {cos($0)},
        "tan": {tan($0)},
        "x²": {$0 * $0},
        "√": { (x) in
            if x >= 0 {
                return sqrt(x)
            }
            return 0
        },
        "x!": { (x) in
            var factorial = 1
            var y = Int(x / 1)
            if y > 0 {
                for i in 1...y {
                    if Int.max / factorial > i {
                        factorial *= i
                    }
                }
            } else {
                factorial = 0
            }
            return Double(factorial)
        },
        "x": {$0}
    ]
    
    func calculateYData() -> [Double] {
        var yData = [Double]()
        
        if expression != nil {
            let function = calculatorDictionary[expression!]!
            for i in 1...1000 {
                yData.append(function(Double(i) / 10 - 50))
            }
        }
        
        return yData
    }
    
}
