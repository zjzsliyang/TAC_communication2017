//
//  ViewController.swift
//  I-Calculator
//
//  Created by LRui on 16/8/3.
//  Copyright © 2016年 lirui. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
//    显示结果
    @IBOutlet weak var resultLabel: UILabel!
//    判断是否是小数
    var isDecimal = false
//    判断原来数字是否是0
    var isZero = true
//    判断是否在输入运算的第二个参数
    var isSecondNumber = false
//    显示在屏幕上的数字
    var resultText: String {
        get {
            return resultLabel.text!
        }
        set {
            resultLabel.text = newValue
        }
    }
//    计算器的Model层
    var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    输入数字
    @IBAction func tapNumber(_ sender: UIButton) {
        if isZero {
            resultText = sender.currentTitle!
            isZero = false
        } else {
            resultText += sender.currentTitle!
        }
    }
//    输入小数点
    @IBAction func tapPoint(_ sender: UIButton) {
        if !isDecimal {
            resultText += "."
            isDecimal = true
        }
    }
//    清空
    @IBAction func tapAC(_ sender: UIButton) {
        resultText = "0"
        isDecimal = false
        isZero = true
    }
//    输入操作符
    @IBAction func tapOperation(_ sender: UIButton) {
        brain.operation(sender.currentTitle!, input: resultText)
        let formatter = NumberFormatter()
        formatter.maximumSignificantDigits = 16
        resultText = formatter.string(from: NSNumber(value: brain.result as Double))!
        isZero = true
    }
}

