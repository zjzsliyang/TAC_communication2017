//
//  GraphViewController.swift
//  II-Graph Calculator
//
//  Created by LRui on 16/8/8.
//  Copyright © 2016年 lirui. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    @IBOutlet weak var expressionLabel: UILabel! {
        didSet {
            if expressionText.hasPrefix("x") {
                expressionLabel.text = expressionText
            } else if expressionText != " " {
                expressionLabel.text = expressionText + "x"
            } else {
                expressionLabel.text = expressionText
            }
        }
    }
    
    var expressionText: String = " " {
        didSet {
            graphModel.expression = expressionText
            if let g = graph {
                g.yData = graphModel.calculateYData()
            }
        }
    }
    
    var graphModel = GraphModel()
    
    @IBOutlet weak var graph: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if expressionText != " " {
            graph.yData = graphModel.calculateYData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
