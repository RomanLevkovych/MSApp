//
//  ContiniousData.swift
//  MSApp
//
//  Created by Roman on 3/11/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class ContiniousData: MSData {
  var data: [Double]

  private let end: Double
  private let start: Double

  init(from characteristic: DataCharacteristic) {
    data = (0...characteristic.amount).map { _ in Double.random(in: Double(characteristic.startInterval)...Double(characteristic.endInterval)) }
    .sorted()
    start = Double(characteristic.startInterval)
    end = Double(characteristic.endInterval)
  }

  func group() -> [Double : Double] {
    var r: Int = 1
    var temp: Int = 2
    while data.count > temp {
      r += 1
      temp *= 2
      print("r: \(r)")
    }
    dump(r)
    r -= 1

    let length = (end - start) / Double(r)
    var res = [Double: Double]()
    var curr = start
    while curr <= end {
      for element in data {
        if element >= curr && element < (curr + length) {
          res[curr, default: 0] += 1
        }

      }
      print("\(curr) handled")
      curr += length
    }
    return res
  }
}
