//
//  ViewController.swift
//  Calculator
//
//  Created by student on 9/7/17.
//  Copyright © 2017 Objective-C Fundamentals. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var display: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        display.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Class variables
    var currentDisplayString = "0"
    
    var decimalCount = 0
    var register1: Double?
    var register2: Double?
    var operand1: String?
    var operand2: String?
    
    // this is only 1-9, 0 and . are special case
    @IBAction func buttonNumberTouch(_ sender: UIButton) {
        if (currentDisplayString == "0" ) {
            currentDisplayString = sender.titleLabel!.text!
        } else {
            if (register1 == nil) {
                currentDisplayString += sender.titleLabel!.text!
            } else { // have a second value
                if (register2 == nil) {
                    if (decimalCount == 1) { // has decimal point
                         currentDisplayString += sender.titleLabel!.text!
                    } else {
                        currentDisplayString = sender.titleLabel!.text!
                    }
                    
                } else {
                    currentDisplayString += sender.titleLabel!.text!
                }
                register2 = Double(currentDisplayString)
            }
        }
        display.text = currentDisplayString
    }
    
    @IBAction func buttonZeroTouch(_ sender: UIButton) {
        if (currentDisplayString == "0" ) {
            currentDisplayString = sender.titleLabel!.text!
        } else {
            if ((register2 == nil) && (register1 != nil)) {
                currentDisplayString = "0"
                display.text = currentDisplayString
            } else {
            if currentDisplayString.characters.count > 0 { // will always be greeater, this test is legacy code to be removed
            currentDisplayString += sender.titleLabel!.text!
            display.text = currentDisplayString
                }
        }
        }
    }
    
    @IBAction func buttonDecimalTouch(_ sender: UIButton) {
        if decimalCount == 0 {
            if (display.text == "0") {
                currentDisplayString = "0."
            } else
            {
            currentDisplayString += sender.titleLabel!.text!
            }
            display.text = currentDisplayString;
            decimalCount = 1
        } else {
            AudioServicesPlaySystemSound(1053)
        }
    }

    
    @IBAction func buttonReverse(_ sender: UIButton) {
        if (display.text != "0") {
            let firstLetter = display.text?.characters.first
            if (firstLetter != "-") {
                currentDisplayString = "-" + display.text!
                
            } else {
                let index = display.text?.index((display.text?.startIndex)!, offsetBy: 1)
                currentDisplayString = (display.text?.substring(from: index!))!
            }
            display.text = currentDisplayString;
            // if its after an operand then then its a new value
            if (register1  != nil){
                register2 = Double(currentDisplayString)
            }

        }
    }
    
    @IBAction func buttonClearAll(_ sender: UIButton) {
        currentDisplayString = "0"
        display.text = "0"
        decimalCount = 0
        register1 = nil
        register2 = nil
        operand1 = nil
        operand2 = nil
    }
    
    @IBAction func buttonOperand(_ sender: UIButton) {
        if (currentDisplayString != "0"){
            if (operand1 == nil) {
                operand1 = sender.titleLabel!.text!
                register1 = Double(currentDisplayString) // might already be set as this, dont care
            } else {
                operand2 = sender.titleLabel!.text!
                register2 = Double(currentDisplayString)            }

        }
    }
    
    @IBAction func buttonTotal(_ sender: UIButton) {
        var total: Double
        if (register2 == nil) { //it's a singleton value
            if (sender.titleLabel!.text! == "%") {
                if (operand1 != nil) {
                // according to the Apple calculator it is ALWAYS (register1) squared / 100, don't care about operands
                    total = (register1! * register1!) / 100
                } else {
                    total = Double(currentDisplayString)! / 100
                }
                register1 = total // this does not clear the registry WARNING, behavior may be strange defects.
                operand1 = nil
                currentDisplayString = removeTrailingZero(total: total)
                display.text = currentDisplayString
            }
            else {//if (sender.titleLabel!.text! == "=") {
                if let thisOperand = operand1 {

                    switch thisOperand {
                    case "+": total = (register1! * 2)
                    currentDisplayString = removeTrailingZero(total: total)
                    case "–": total = 0
                    currentDisplayString = removeTrailingZero(total: total)
                        case "×": total = (register1! * register1!)
                        currentDisplayString = removeTrailingZero(total: total)
                        
                        default: // divide
                        if (register1 == 0) {
                            currentDisplayString = "Not a number"
                            register1 = nil
                        } else {
                            total = 1
                            currentDisplayString = "1"
                        }
                        
                    }
                    operand1 = nil
                    display.text = currentDisplayString

                } // else operand1 ia nil and NOOP
            }

        } else { // its binary
            if let thisOperand = operand1 {
                
                switch thisOperand {
               // case "+": total = (register1! * 2)
               // currentDisplayString = removeTrailingZero(total: total)
               // case "–": total = 0
              //  currentDisplayString = removeTrailingZero(total: total)
                    
                case "×": total = (register1! * register2!)
                    currentDisplayString = removeTrailingZero(total: total)
                register1 = total;
                    register2 = nil
                    operand1 = nil
                    decimalCount = 0
                    operand1 = nil
                default: // divide
                    if (register2 == 0) {
                        currentDisplayString = "Not a number"
                        register1 = nil
                    } else {
                        total = register1! / register2!
                        currentDisplayString = removeTrailingZero(total: total)
                        register1 = total
                        register2 = nil
                        decimalCount = 0
                        operand1 = nil
                        
                    }
                    
                }
                
                operand1 = nil
                
                display.text = currentDisplayString
                
                
            }
 
        }
        
        
        decimalCount = 0
    }
    func removeTrailingZero(total: Double) -> String{
        let tempVar = String(format: "%g", total)
        return tempVar
    }}
