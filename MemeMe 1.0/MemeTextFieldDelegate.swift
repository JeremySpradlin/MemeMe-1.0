//
//  MemeTextFieldDelegate.swift
//  MemeMe 1.0
//
//  Created by Jeremy Spradlin on 10/8/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    //Functions for text field delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Inside textFieldDidBeginEditing")
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
