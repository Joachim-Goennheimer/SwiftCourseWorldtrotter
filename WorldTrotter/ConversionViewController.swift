//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Joachim Goennheimer on 04.03.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

//import Foundation

import UIKit


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fahrenheitField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusValue()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    var numberFormatter: NumberFormatter {
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }
    
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        updateCelsiusValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .random()
    }
    
    
    @IBAction func fahrenheitFieldEditChanged(_ sender: Any) {
        
        if let text = fahrenheitField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
        
    }
    
    func updateCelsiusValue() {
    
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
//        bronze challenge chapter 4
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.,")
        let replacementStringCharacters = CharacterSet(charactersIn: string)
        
        if !replacementStringCharacters.isSubset(of: allowedCharacters) {
          return false
        }
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    
    
    
}
