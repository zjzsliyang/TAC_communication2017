//
//  CalculatorViewController.swift
//  II-Graph Calculator
//
//  Created by LRui on 16/8/8.
//  Copyright © 2016年 lirui. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

//    上面一行显示计算结果
    @IBOutlet weak var resultLabel: UILabel!
    var resultText: String {
        get {
            return resultLabel.text!
        }
        set {
            resultLabel.text = newValue
        }
    }
//    下面一行显示计算过程表达式
    @IBOutlet weak var processLabel: UILabel!
    var processText: String {
        get {
            return processLabel.text!
        }
        set {
            processLabel.text = newValue
        }
    }
    
//    判断是否输入新数字
    var isNewNumber: Bool = true
//    判断是否是新算式
    var isNewProcess: Bool = true
//    判断是否是小数
    var isDecimal: Bool = false
//    是否含有未知数X
    var hasX: Bool = false
//    计算器model
    var calModel = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapNumber(_ sender: UIButton) {
        if !hasX {
            if isNewNumber {
                resultText = sender.currentTitle!
                isNewNumber = false
            } else {
                resultText += sender.currentTitle!
            }
        }
        
        if isNewProcess {
            processText = sender.currentTitle!
            isNewProcess = false
        } else {
            processText += sender.currentTitle!
        }
    }
    
    @IBAction func tapPoint(_ sender: UIButton) {
        if isNewNumber {
            resultText = "0."
            isNewNumber = false
        } else {
            if !isDecimal {
                resultText += "."
            }
        }
        isDecimal = true
    }
    
    fileprivate func updateCalculatorState(_ process: Bool, number: Bool, decimal: Bool, pText: String?, rText: String?) {
        isNewProcess = process
        isNewNumber = number
        isDecimal = decimal
        if let pT = pText {
            processText = pT
        }
        if let rT = rText {
            resultText = rT
        }
    }
    
    @IBAction func tapSymbol(_ sender: UIButton) {
        let title = sender.currentTitle!
        if !hasX {
            switch title {
            case "AC":
                calModel.operation(title, value: Double(resultText)!)
                updateCalculatorState(true, number: true, decimal: false, pText: "0", rText: "0")
            case "=":
                calModel.operation(title, value: Double(resultText)!)
                updateCalculatorState(true, number: true, decimal: false, pText: calModel.outputResult, rText: calModel.outputResult)
            case "+", "-", "×", "÷":
                if !isNewNumber {
                    calModel.operation(title, value: Double(resultText)!)
                    updateCalculatorState(false, number: true, decimal: false, pText: processText + title, rText: calModel.outputResult)
                }
            case "sin", "cos", "tan", "√":
                calModel.operation(title, value: Double(resultText)!)
                if isNewNumber {
                    updateCalculatorState(false, number: false, decimal: false, pText: title + "(" + processText + ")", rText: calModel.outputResult)
                } else {
                    processText.replaceSubrange((processText.range(of: resultText))!, with: title + "(" + resultText + ")")
                    updateCalculatorState(false, number: false, decimal: false, pText: nil, rText: calModel.outputResult)
                } 
            case "x²", "x!":
                calModel.operation(title, value: Double(resultText)!)
                if isNewNumber {
                    updateCalculatorState(false, number: false, decimal: false, pText: "(" + processText + ")" + title, rText: calModel.outputResult)
                } else {
                    processText.replaceSubrange(processText.range(of: resultText)!, with: "(" + resultText + ")" + title.substring(from: title.characters.index(title.startIndex, offsetBy: 1)))
                    updateCalculatorState(false, number: false, decimal: false, pText: nil, rText: calModel.outputResult)
                }
            case "Graph":
                hasX = true
                updateCalculatorState(true, number: true, decimal: false, pText: "0", rText: "0")
            default:
                break
            }
        } else {
            if title == "AC" {
                updateCalculatorState(true, number: true, decimal: false, pText: "0", rText: "0")
                hasX = false
            } else {
                switch title {
                case "sin", "cos", "tan", "x²", "√", "x!", "x":
                    performSegue(withIdentifier: "showGraph", sender: sender)
                default:
                    break
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if hasX {
            if let nVC = segue.destination as? UINavigationController {
                if let gVC = nVC.visibleViewController as? GraphViewController {
                    gVC.expressionText = (sender as! UIButton).currentTitle!
                }
            }
        }
    }
}
