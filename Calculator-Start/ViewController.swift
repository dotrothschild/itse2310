//
//  ViewController.swift
//  Calculator
//
//  Created by Shimon Rothschild on 9/7/17.
//  Copyright © 2017 Shimon Rothschild. All rights reserved.


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UITextField!
    
    // MARK: - Class variables
    var currentDisplayString = "0"
    var hasFractionalSeparator = false
    var isNewOperand = true
    var operand1: Double?
    var operand2: Double?
    var operand3: Double?
    var operation1: String?
    var operation2: String?
    
    @IBAction func buttonClearAll(_ sender: UIButton) {
        if buttonClearAll.titleLabel?.text == "AC"{
            initVars()
        } else {
            currentDisplayString = "0"
            if (operation1 == nil) { // this is a HACK to fix unary %
                operand1 = nil
            }
            display.text = currentDisplayString
            isNewOperand = true;
            changeButtonClearAllTitle()
        }
        
    }
    @IBOutlet weak var buttonClearAll: UIButton!
    
    @IBAction func buttonReverse(_ button: UIButton) {
        if (display.text != "0") {
            let firstLetter = display.text?.characters.first
            if (firstLetter != "-") {
                currentDisplayString = "-" + display.text!
                
            } else {
                currentDisplayString = "-"+currentDisplayString
            }
            display.text = currentDisplayString;
        }
    }
    @IBAction func buttonPercent(_ button: UIButton) {
        if (operand1 == nil) {
            operand1 = Double(currentDisplayString)! / 100
            currentDisplayString = String.localizedStringWithFormat("%g", operand1!)
            
        } else {
            operand2 = (operand1! * operand1!) / 100 //this is Apple implementation
            currentDisplayString = String.localizedStringWithFormat("%g", operand2!)        }
        display.text = currentDisplayString
    }
    @IBAction func buttonNumberTouch(_ button: UIButton) {
        buttonClearAll.titleLabel?.text = " C"
        if (isNewOperand){ // only for create first number
            currentDisplayString = button.titleLabel!.text!
            
 
        } else {
            currentDisplayString += button.titleLabel!.text!
            
        }
        isNewOperand = false
        display.text = currentDisplayString
    } // end buttonNumberTouch
    @IBAction func buttonFractionalSeparatorTouch(_ button: UIButton) {
        if isNewOperand {
            currentDisplayString = "0."
            display.text = currentDisplayString
            isNewOperand = false
            hasFractionalSeparator = true
        } else {
            if !hasFractionalSeparator {
                currentDisplayString += button.titleLabel!.text!
                display.text = currentDisplayString;
                hasFractionalSeparator = true
            } else {
                AudioServicesPlaySystemSound(1053)
            }
        }
    }
    @IBAction func buttonOperation(_ button: UIButton) {
        if (operation1 == nil) {
            if (button.titleLabel!.text! != "=") { // if = not saving display or operation, no erase, but no operation
                operand1 = Double(currentDisplayString)
                operation1 = button.titleLabel!.text!
            }
        } else { // Apple this situation operand2 NEVER = 0
            if (operand2 == nil) {
                operand2 = Double(currentDisplayString)
            }
            switch button.titleLabel!.text! {
                
            case "÷", "×":
                if (operation1 == "×") {
                    operand1 = operand1! * operand2!
                    operand2 = nil;
                    operation1 = button.titleLabel!.text!
                } else {
                    if (operation1 == "÷"){
                        operand1 = operand1! / operand2!
                        operand2 = nil
                        operation1 = button.titleLabel!.text!
                    } else { // order of operations so wait to calculate
                        operation2 = button.titleLabel!.text!
                    }
                }
            case "–", "+", "=":
                if (operation2 == nil) {// not an order of operatation complication
                    switch operation1! {
                    case "÷":
                        operand1 = operand1! / operand2!
                        operand2 = nil
                        operation1 = button.titleLabel!.text!
                    case "×":
                        operand1 = operand1! * operand2!
                        operand2 = nil
                        operation1 = button.titleLabel!.text!
                    case "–":
                        operand1 = operand1! - operand2!
                        operand2 = nil
                        operation1 = button.titleLabel!.text!
                    case "+":
                        operand1 = operand1! + operand2!
                        operand2 = nil
                        operation1 = button.titleLabel!.text!
                    default:
                        break;
                    }
                } else {
                    operand3 = Double(currentDisplayString)
                    if (operation2 == "×") {
                        operand2 = operand3! * operand2!
                    }
                    if (operation2 == "÷"){
                        operand2 = operand3! / operand2!
                    }
                    if (operation1 ==  "–") {
                        operand1 = operand1! - operand2!
                        operation1 = button.titleLabel!.text!
                    }
                    if (operation1 ==  "+") {
                        operand1 = operand1! + operand2!
                        operation1 = button.titleLabel!.text!
                    }
                    // only thing remaining in memory is operand1 an operation1 if operation2 is = then operation1 also nil
                    operand3 = nil
                    operand2 = nil
                    operand2 = nil
                }
            default:
                break;
            }
            if (button.titleLabel!.text! == "=") {
                operation1 = nil
                operation2 = nil
                operand2 = nil
            }
        }
        
        hasFractionalSeparator = false
        isNewOperand = true
        //buttonClearAll.titleLabel?.text = "AC"
        // if operand2 not nil its order of operations in progress
        if (operand2 == nil) {
            currentDisplayString = String.localizedStringWithFormat("%g", operand1!)
            display.text = currentDisplayString
        }
    }
    // MARK: - System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //initVars()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Private methods
    func initVars() -> Void{
        currentDisplayString = "0"
        display.text = currentDisplayString
        hasFractionalSeparator = false
        isNewOperand = true;
        //    buttonClearDisplay.titleLabel!.text! = "AC"
        operand1 = nil
        operand2 = nil
        operand3 = nil
        operation1 = nil
        operation2 = nil
    }
    func changeButtonClearAllTitle() -> Void {
        if buttonClearAll.titleLabel?.text == "AC"{
           buttonClearAll.titleLabel?.text = " C"
        } else {
            buttonClearAll.titleLabel?.text = "AC"
        }
    }
} // end of class
