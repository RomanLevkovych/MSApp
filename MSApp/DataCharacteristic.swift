//
//  DataCharacteristic.swift
//  MSApp
//
//  Created by Roman on 3/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

enum DataType {
  case discrete
  case continious
}

struct DataCharacteristic {
  let startInterval: Int
  let endInterval: Int
  let type: DataType
  let amount: Int
}
