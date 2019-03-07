//
//  ViewController.swift
//  MSApp
//
//  Created by Roman on 3/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class DataDescriptionViewController: UIViewController {

  // MARK: - UI Elements
  @IBOutlet weak var startIntervalTextField: UITextField!
  @IBOutlet weak var endIntervalTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var sequenceTypeSegmentedControl: UISegmentedControl!

  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func generateSequence(_ sender: UIButton) {
    guard
      let start = Int(startIntervalTextField.text ?? ""),
      let end = Int(endIntervalTextField.text ?? ""),
      let amount = Int(amountTextField.text ?? "")
    else {
      return
    }
    let type = sequenceTypeSegmentedControl.selectedSegmentIndex

    let dataCharacteristic = DataCharacteristic.init(startInterval: start,
                                                     endInterval: end,
                                                     type: DataType(rawValue: type)!,
                                                     amount: amount)
    let temp = DiscreteData(from: dataCharacteristic)
  }
}

extension DataDescriptionViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}
