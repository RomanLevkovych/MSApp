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

  init(from characteristic: DataCharacteristic) {
    data = (0...characteristic.amount).map { _ in Double.random(in: Double(characteristic.startInterval)...Double(characteristic.endInterval)) }
  }
}
