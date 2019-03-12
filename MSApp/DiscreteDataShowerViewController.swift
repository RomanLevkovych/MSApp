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

  @IBOutlet weak var lineDataDescriptionChartView: LineChartView!
  @IBOutlet weak var barDataDescriptionChartView: BarChartView!
  @IBOutlet weak var empiricLineChartView: LineChartView!

  var sequence: MSData = DiscreteData()

  // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      if sequence.data.count == 0 {
        self.navigationController?.popViewController(animated: true)
      }

      averageLabel.text    = (averageLabel.text ?? "")    + String(describing: sequence.average)
      deviationLabel.text  = (deviationLabel.text ?? "")  + String(describing: sequence.deviation)
      dispersionLabel.text = (dispersionLabel.text ?? "") + String(describing: sequence.dispersion)
      mediaLabel.text      = (mediaLabel.text ?? "")      + String(describing: sequence.median)
      rangeLabel.text      = (rangeLabel.text ?? "")      + String(describing: sequence.range)
      modeLabel.text       = (modeLabel.text ?? "")       + sequence.mode.reduce(into: "") { acc, item in acc += "\n\(item) " }
      standardLabel.text   = (standardLabel.text ?? "")   + String(describing: sequence.standard)

      variationSequenceLabel.text = sequence.data.reduce(into: "") { acc, item in acc += "\n\(item) " }

      setUpPolygon()
      setUpHistogram()
      setUpEmpiricFunc()
    }

  func setUpPolygon() {
    let values = sequence.group()
      .sorted { $0.key < $1.key }
      .map { ChartDataEntry(x: $0.key, y: Double($0.value)) }
   // dump(values)
    let dataSet  = LineChartDataSet(values: values, label: "Полігон")
    let data = LineChartData(dataSet: dataSet)

    lineDataDescriptionChartView.data = data
  }

  func setUpHistogram() {
    let values = sequence.group()
      .sorted { $0.key < $1.key }
      .map { BarChartDataEntry(x: $0.key, y: $0.value) }
    let dataSet = BarChartDataSet(values: values, label: "Гістограма")
    let data = BarChartData(dataSet: dataSet)

    barDataDescriptionChartView.data = data
  }

  func setUpEmpiricFunc() {
    var values = [ChartDataEntry]()
    let data = sequence.group().sorted { $0.key < $1.key }
    let count: Double = Double(sequence.group().values.reduce(0, +))
    var currSum: Double = 0.0
    values.append(ChartDataEntry(x: data[0].key-2, y: currSum))
    /*
     Беремо перший елемент - ставимо нуль, потім дублюємо кожен елемент зі старим значенням і новим, получимо сходки
     1    _
   0.5  _|
   0  _|
     */

    for i in 0..<data.count {
      values.append(ChartDataEntry(x: data[i].key, y: currSum))
      currSum += data[i].value / count
      values.append(ChartDataEntry(x: data[i].key, y: currSum))
    }

    values.append(ChartDataEntry(x: data[data.count-1].key + 2, y: currSum))

    let dataSet  = LineChartDataSet(values: values, label: "Емпірична функція розподілу")
    let chartData = LineChartData(dataSet: dataSet)
    dump(values)
    empiricLineChartView.data = chartData
  }
}
