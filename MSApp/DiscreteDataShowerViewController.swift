//
//  DiscreteDataShowerViewController.swift
//  MSApp
//
//  Created by Roman on 3/6/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit
import Charts

class DiscreteDataShowerViewController: UIViewController {

  // MARK: - UI Components
  @IBOutlet weak var averageLabel: UILabel!
  @IBOutlet weak var deviationLabel: UILabel!
  @IBOutlet weak var dispersionLabel: UILabel!
  @IBOutlet weak var mediaLabel: UILabel!
  @IBOutlet weak var modeLabel: UILabel!
  @IBOutlet weak var rangeLabel: UILabel!
  @IBOutlet weak var standardLabel: UILabel!
  @IBOutlet weak var variationSequenceLabel: UILabel!
  @IBOutlet weak var dataDescriptionChartView: LineChartView!

  var sequence: MSData = DiscreteData()

  // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

      averageLabel.text    = (averageLabel.text ?? "")    + String(describing: sequence.average)
      deviationLabel.text  = (deviationLabel.text ?? "")  + String(describing: sequence.deviation)
      dispersionLabel.text = (dispersionLabel.text ?? "") + String(describing: sequence.dispersion)
      mediaLabel.text      = (mediaLabel.text ?? "")      + String(describing: sequence.median)
      rangeLabel.text      = (rangeLabel.text ?? "")      + String(describing: sequence.range)
      modeLabel.text       = (modeLabel.text ?? "")       + String(describing: sequence.mode)
      standardLabel.text   = (standardLabel.text ?? "")   + String(describing: sequence.standard)
      
      variationSequenceLabel.text = sequence.data.reduce(into: "") { acc, item in acc += "\(item) " }
    }
}
