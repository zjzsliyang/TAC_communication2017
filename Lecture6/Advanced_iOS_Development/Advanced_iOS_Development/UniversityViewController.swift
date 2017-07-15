//
//  UniversityViewController.swift
//  Advanced_iOS_Development
//
//  Created by 李锐 on 2017/7/13.
//  Copyright © 2017年 李锐. All rights reserved.
//

import UIKit

struct University {
  var name: String
  var url: String
}

class UniversityViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var universities: [University] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let queue = DispatchQueue.global(qos: .userInteractive)
    queue.async {
      do {
        guard let url = URL(string: "http://universities.hipolabs.com/search?name=university") else { return }
        let data = try Data(contentsOf: url)
        let jsonOptional = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let json = jsonOptional as? [Any] {
          for universityOptional in json {
            if let university = universityOptional as? [String: Any] {
              if let name = university["name"] as? String, let url = university["web_page"] as? String {
                self.universities.append(University(name: name, url: url))
              }
            }
          }
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
      } catch {
        print("error")
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension UniversityViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return universities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "UNIVERSITY_CELL")
    if cell == nil { cell = UITableViewCell() }
    
    if indexPath.row < universities.count {
      let university = universities[indexPath.row]
      cell?.textLabel?.text = university.name
      cell?.detailTextLabel?.text = university.url
    }
    
    return cell!
  }
}
