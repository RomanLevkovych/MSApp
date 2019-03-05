//
//  DiscreteData.swift
//  MSApp
//
//  Created by Roman on 3/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class DiscreteData {
  let data: [Int]

  init(from characteristics: DataCharacteristic) {
    data = (0..<characteristics.amount).map {_ in
      Int.random(in: characteristics.intervalStart...characteristics.intervalEnd)
    }
  }

  func quantil(alpha: Int) -> Int? {
    let q = Int(Double(data.count * alpha) / 100.0 - 1)
    if q > 0 {
      return data[q]
    } else {
      return nil
    }
  }

  var median: Double {
    return data.count % 2 == 0 ?
      Double((data[data.count/2] + data[data.count/2]))/2.0 : Double(data[data.count/2])
  }

  var mode: [Int] {
    let max = data.reduce(into: [:]) { res, item in res[item, default: 0] += 1}.max { $0.value < $1.value }?.value

    return data.filter { $0 == max }
  }

  var average: Double {
    return Double(data.reduce(0, +)) / Double(data.count)
  }

  var deviation: Double {
    let av = average
    return data.reduce(into: 0) { $0 += (Double($1) - av)*(Double($1) - av) }
  }

  var range: Int {
    return data.max()! - data.min()!
  }

  var varianza: Double {
    return deviation/Double(data.count - 1)
  }

  var standard: Double {
    return sqrt(varianza)
  }

  var dispersion: Double {
    return deviation / Double(data.count)
  }

  var variation: Double {
    return standard / average
  }
}
