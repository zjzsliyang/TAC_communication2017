//
//  ImageViewController.swift
//  Advanced_iOS_Development
//
//  Created by 李锐 on 2017/7/13.
//  Copyright © 2017年 李锐. All rights reserved.
//

import UIKit

let imgUrl1 = "http://www.005.tv/uploads/allimg/170503/33-1F503093KOa.jpg"
let imgUrl2 = "http://www.005.tv/uploads/allimg/170503/33-1F503093GG12.jpg"

class ImageViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  private var isFirst: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getImageFromInternet(url: imgUrl1, completion: changeImage)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func getImageFromInternet(url: String, completion: ((UIImage) -> ())? = nil) {
    guard let url = URL(string: url) else { return }
    
    let queue = DispatchQueue.global(qos: .userInteractive)
    queue.async {
      do {
        let data = try Data(contentsOf: url)
        if let completion = completion, let image = UIImage(data: data) {
          DispatchQueue.main.async {
            completion(image)
          }
        }
      } catch {
        print(error)
      }
    }
  }
  
  private func changeImage(image: UIImage?) {
    guard let image = image else { return }
    
    self.imageView.image = image
  }
  
  @IBAction func tapButton(_ sender: Any) {
    let imgUrl = isFirst ? imgUrl2 : imgUrl1
    getImageFromInternet(url: imgUrl, completion: changeImage)
    
    isFirst = !isFirst
  }
}
