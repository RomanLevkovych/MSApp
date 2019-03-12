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

  var dataCharacteristic = DataCharacteristic()

  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround() 
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

    dataCharacteristic = DataCharacteristic(start: start, finish: end, type: DataType(rawValue: type)!, amount: amount)
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "discreteIdentifier":
      guard let vc = segue.destination as? DiscreteDataShowerViewController else { return }
      switch dataCharacteristic.type {
      case .discrete:
        vc.sequence = DiscreteData(from: dataCharacteristic)
      case .continious:
        vc.sequence = ContiniousData(from: dataCharacteristic)
      }
      dump(vc.sequence)
    default:
      return
    }
  }
}

extension DataDescriptionViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
  }
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
