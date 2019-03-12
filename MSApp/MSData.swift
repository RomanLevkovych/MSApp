//
//  MSData.swift
//  MSApp
//
//  Created by Roman on 3/11/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

protocol MSData {
  var data: [Double] { get }

  func group() -> [Double:Double]

  func quantil(alpha: Double) -> Double?
  var median: Double { get }
  var mode: [Double] { get }
  var average: Double { get }
  var deviation: Double { get }
  var range: Double { get }
  var varianza: Double { get }
  var standard: Double { get }
  var dispersion: Double { get }
  var variation: Double { get }
}

extension MSData {
  func quantil(alpha: Double) -> Double? {
    let q = Int(Double(data.count) * alpha / 100.0 - 1)
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

  var mode: [Double] {
    let table = data.reduce(into: [:]) { res, item in res[item, default: 0] += 1}
    let max = data.reduce(into: [:]) { res, item in res[item, default: 0] += 1}.max { $0.value < $1.value }!.value
    let m = Array<Double>(table.filter { $0.value == max }.keys)
    return Array<Double>(Set<Double>(data.filter { m.contains($0) }))
  }

  var average: Double {
    return Double(data.reduce(0, +)) / Double(data.count)
  }

  var deviation: Double {
    let av = average
    return data.reduce(0.0) { $0 + (Double($1) - av)*(Double($1) - av) }
  }

  var range: Double {
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
