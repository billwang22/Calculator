//
//  ViewController.swift
//  Calculator
//
//  Created by lwang on 16/7/11.
//  Copyright © 2016年 lwang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsIntypeofMiddleCharter = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsIntypeofMiddleCharter){
         display.text = display.text! + digit
        }else{
            display.text = digit
            userIsIntypeofMiddleCharter = true
        }
    }


    @IBAction func operate(sender: UIButton) {
        if userIsIntypeofMiddleCharter == true{
            enter()
        }
        
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }

        
    }

    @IBAction func enter() {
          userIsIntypeofMiddleCharter=false
//        openrandStack.append(displayValue)
//        print(openrandStack)
       if  let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            userIsIntypeofMiddleCharter = false
            display.text = newValue.description
        }
    }
    

}

