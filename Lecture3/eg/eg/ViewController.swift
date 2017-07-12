//
//  ViewController.swift
//  eg
//
//  Created by mac on 17/7/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var theme: UILabel!
    @IBOutlet weak var article: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1
        self.navigationController?.isNavigationBarHidden = true
        //4
        theme.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(transform(_:))))
        
        article.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(transform(_:))))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //2
    @IBAction func transform(_ sender: UIButton) {
        performSegue(withIdentifier: "yo", sender: sender)
        setSecondView()
    }
    //3
    func transform(){
        self.performSegue(withIdentifier: "yo", sender: self)
        setSecondView()
    }
    //5
    func setSecondView(){
        self.navigationController?.isNavigationBarHidden = false
        
        //transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    
    


}

