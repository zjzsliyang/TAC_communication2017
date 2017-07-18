//
//  LocalData.swift
//  ForMe
//
//  Created by 李锐 on 2017/7/16.
//  Copyright © 2017年 李锐. All rights reserved.
//

import Foundation

struct Item {
  var title: String
  var subtitle: String?
}

class LocalData {
  static let userDefault = UserDefaults.standard
  static func addItem(item: Item) {
    let array = LocalData.userDefault.array(forKey: "items")
    var newArray: [Item]
    if let array = array as? [Item] {
      newArray = array
    } else {
      newArray = []
    }
    
    newArray.append(item)
    LocalData.userDefault.set(newArray, forKey: "items")
  }
  
  static func getItems() -> [Item] {
    let items = LocalData.userDefault.array(forKey: "items") as? [Item]
    return (items == nil) ? [] : items!
  }
  
  private init() {}
}
