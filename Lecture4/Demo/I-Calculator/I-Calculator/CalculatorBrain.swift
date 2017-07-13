//
//  CalculatorBrain.swift
//  I-Calculator
//
//  Created by LRui on 16/8/3.
//  Copyright © 2016年 lirui. All rights reserved.
//

import Foundation

class CalculatorBrain {
//    计算数值
    fileprivate var accumulator: Double
    var result: Double {
        return accumulator
    }
//    操作类型
    enum OperationType {
        case constant(Double)
        case unaryOperator((Double) -> Double)
        case binaryOperator((Double, Double) -> Double)
        case result
        case clear
    }
//    二元运算信息
    struct BinaryInfo {
        var firstNumber: Double
        var function: (Double, Double) -> Double
    }
//    操作字典
    let operatorDictionary: Dictionary<String, OperationType> = [
//        常数
        "e": OperationType.constant(M_E),
        "π": OperationType.constant(M_PI),
//        一元运算
        "x²": OperationType.unaryOperator({$0 * $0}),
        "x!": OperationType.unaryOperator({(num: Double) -> Double in
            var sum = 1
            for i in 1...Int(num) {
                sum *= i
            }
            return Double(sum)
        }),
        "√x": OperationType.unaryOperator({sqrt($0)}),
        "sin": OperationType.unaryOperator({sin($0)}),
        "cos": OperationType.unaryOperator({cos($0)}),
        "tan": OperationType.unaryOperator({tan($0)}),
        "eⁿ": OperationType.unaryOperator({pow(M_E, $0)}),
//        二元运算
        "+": OperationType.binaryOperator({$0 + $1}),
        "−": OperationType.binaryOperator({$0 - $1}),
        "×": OperationType.binaryOperator({$0 * $1}),
        "÷": OperationType.binaryOperator({$0 / $1}),
        "xⁿ": OperationType.binaryOperator({pow($0, $1)}),
//        结果
        "=": OperationType.result,
//        清零
        "AC": OperationType.clear
    ]
//    二元运算信息实体
    fileprivate var binaryInfo: BinaryInfo?
//    计算二元运算
    fileprivate func calculateBinary() {
        if binaryInfo != nil {
            accumulator = (binaryInfo?.function(binaryInfo!.firstNumber, accumulator))!
            binaryInfo = nil
        }
    }
    
    func operation(_ op: String, input: String) {
        let operatorValue = operatorDictionary[op]!
        accumulator = Double(input)!
        
        switch operatorValue {
        case .constant(let num):
            accumulator = num
        case .unaryOperator(let function):
            accumulator = function(accumulator)
        case .binaryOperator(let function):
            calculateBinary()
            binaryInfo = BinaryInfo(firstNumber: accumulator, function: function)
        case .clear:
            accumulator = 0
            binaryInfo = nil
        case .result:
            calculateBinary()
        }
    }
    
    //    初始化
    init() {
        accumulator = 0
    }
}
