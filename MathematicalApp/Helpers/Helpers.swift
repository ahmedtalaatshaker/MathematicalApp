//
//  Helpers.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import Foundation
import UIKit

enum Mathoperations:String {
    case ADD = "+"
    case SUP = "-"
    case MUL = "*"
    case DIV = "/"
}

enum apiKey:String{
    case key = "AIzaSyCg7c6qInxOr6fGMsa2SdxOr_8MCHkCW7M"
}

class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}

