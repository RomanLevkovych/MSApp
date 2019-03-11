//
//  DataCharacteristic.swift
//  MSApp
//
//  Created by Roman on 3/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

enum DataType: Int {
  case discrete = 0
  case continious = 1
}

struct DataCharacteristic {
  let startInterval: Int
  let endInterval: Int
  let type: DataType 
  let amount: Int

  init(start: Int = 0,
       finish: Int = 0,
       type: DataType = .discrete,
       amount: Int = 0) {
    startInterval = start
    endInterval = finish
    self.type = type
    self.amount = amount
  }
}
