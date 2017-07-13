//
//  CalculatorModel.swift
//  II-Graph Calculator
//
//  Created by LRui on 16/8/8.
//  Copyright © 2016年 lirui. All rights reserved.
//

import Foundation

class CalculatorModel {
//    计算结果
    fileprivate var accumulator: Double = 0
    var outputResult: String {
        return String(accumulator)
    }
    
    fileprivate enum OperationType {
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case x
        case result
        case clear
    }
    
    fileprivate struct BinaryInfo {
        var firstNumber: Double
        var function: (Double, Double) -> Double
    }
    
    fileprivate var binaryInfo: BinaryInfo?
    
    fileprivate let operationDictionary = [
//        一元运算
        "sin": OperationType.unary({sin($0)}),
        "cos": OperationType.unary({cos($0)}),
        "tan": OperationType.unary({tan($0)}),
        "x²": OperationType.unary({pow($0, 2)}),
        "√": OperationType.unary({sqrt($0)}),
        "x!": OperationType.unary({ (x) in
            var factorial = 1
            for i in 1...Int(x) {
                factorial *= i
            }
            return Double(factorial)
        }),
//        二元运算
        "+": OperationType.binary({$0 + $1}),
        "-": OperationType.binary({$0 - $1}),
        "×": OperationType.binary({$0 * $1}),
        "÷": OperationType.binary({$0 / $1}),
//        输入未知数X
        "x": OperationType.x,
//        "="计算结果
        "=": OperationType.result,
//        清零
        "AC": OperationType.clear
    ]
    
    fileprivate func calculateBinary() {
        if let bI = binaryInfo {
            accumulator = bI.function(bI.firstNumber, accumulator)
            binaryInfo = nil
        }
    }
    
    func operation(_ op: String, value: Double) {
        accumulator = value
        
        switch operationDictionary[op]! {
        case .unary(let function):
            accumulator = function(accumulator)
        case .binary(let function):
            calculateBinary()
            binaryInfo = BinaryInfo(firstNumber: accumulator, function: function)
        case .x:
            break
        case .result:
            calculateBinary()
        case .clear:
            accumulator = 0
            binaryInfo = nil
        }
    }
}
