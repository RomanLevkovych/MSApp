//
//  DiscreteData.swift
//  MSApp
//
//  Created by Roman on 3/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class DiscreteData: MSData {
  let data: [Double]

  init(from characteristics: DataCharacteristic) {
    data = (0..<characteristics.amount).map {_ in
      Double(Int.random(in: characteristics.startInterval...characteristics.endInterval))
    }.sorted()
  }

  init() {
    data = []
  }

  func group() -> [Double : Double] {
    return data.reduce(into: [:]) { acc, item in acc[item, default: 0.0] += 1.0 }
  }
}
