//
//  HomeViewController.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import UIKit

class HomeViewController: mainViewController,UITextFieldDelegate {

    @IBOutlet weak var equationField: CustomUITextField!
    var mathOperator = ""
    let opertors = ["+","-","*","/"]
    @IBOutlet weak var delayCount: CustomUITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmDB.shared.readFinishedEquations()
        equationField.delegate = self
        hideKeyboardWhenTappedAround()
        setCalculateButtonView()
        // Do any additional setup after loading the view.
    }
    
    func setCalculateButtonView(){
        calculateButton.layer.borderWidth = 2
        calculateButton.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        calculateButton.layer.cornerRadius = 8
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == equationField {
            if string.isEmpty{
                return true
            }
            
            if opertors.first(where: {$0 == string}) != nil {
                mathOperator = string
                print(string)
            }
            
            let regex = "[0-9*+/-]{1,}"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with:string)
        }
        return false
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        if sender.text != "" {
            calculateButton.isEnabled = true
            
            var foundOperatorCount = 0
            for char in sender.text!{
                for operato_r in opertors{
                    if operato_r == String(char){
                        foundOperatorCount += 1
                    }
                }
            }
            if foundOperatorCount > 1{
                sender.text?.removeLast()
            }else if foundOperatorCount == 0 {
                mathOperator = ""
            }
        }
    }
    
    @IBAction func calculate(_ sender: Any) {
        makeCalculations()
    }
    
    func makeCalculations() -> Bool{
        if equationField.text == ""{
            alert(message: "Please Enter an Equation", viewController: self)
            return false
        }else if mathOperator == "" {
            alert(message: "Invalid Equation\nPlease Add an Operator", viewController: self)
            return false
        }else if ((equationField.text?.last?.isNumber) != nil) &&
                 !equationField.text!.last!.isNumber {
            alert(message: "Invalid Equation\nPlease Enter a number after Operator", viewController: self)
            return false
        }else{
            realmDB.shared.writePendingEquation(equation: equationField.text!)
            calculator.shared.makeCalculations(text: equationField.text!, equationOperator: mathOperator, delay: Int(delayCount.text ?? "0") ?? 0) { (equation,value) in
                print(value)
                DispatchQueue.main.async {
                    realmDB.shared.writeFinishedEquation(equation: equation, result: value)
                    if (self.navigationController?.topViewController as! TabBarViewController).selectedIndex == 1{
                        ResultsViewController.resultsController.setNewRecord(equation: equation,value:value)

                    }
                }
            }
            return true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
