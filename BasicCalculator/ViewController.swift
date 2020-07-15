//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Anthony Hopkins on 2020-07-12.
//  Copyright © 2020 Anthony Hopkins. All rights reserved.
//

import UIKit

enum Operation:String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case NULL = "Empty"
}

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var outputLabel: UILabel!
    
    //MARK: Variables
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .NULL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        outputLabel.text = "0"
    }
    
    //MARK: Button functions
    @IBAction func numberPressed(_ sender: RoundButton) {
        
        //Limit number of digits to 9
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
        }
    }
    @IBAction func allClearPressed(_ sender: RoundButton) {
        
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        outputLabel.text = "0"
    }
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        
        //Last character cannot be a dot
        if runningNumber.count <= 7 && !runningNumber.contains(".") {
            if (outputLabel.text == "0"){
                runningNumber = ""
                runningNumber = "0."
                outputLabel.text = runningNumber
            }
            else {
                runningNumber += "."
                outputLabel.text = runningNumber
            }
        }
    }
    
    @IBAction func equalsPressed(_ sender: RoundButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
        operation(operation: .Add)
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        operation(operation: .Divide)
    }
    
    //MARK: Private Functions
    
    private func operation(operation: Operation) {
        if currentOperation != .NULL {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                switch (currentOperation) {
                case .Add:
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                    
                case .Subtract:
                result = "\(Double(leftValue)! - Double(rightValue)!)"
                    
                case .Multiply:
                    result = "\(Double(leftValue)! * Double(rightValue)!)"

                case .Divide:
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                    
                default:
                    fatalError("Unexpected Operation...")
                }
                
                leftValue = result
                
                //Find out if result is an integer
                if(Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
            }
            currentOperation = operation
        }
        else {
            //If string is empty it should be interpreted as a 0
            leftValue = "0"
            runningNumber = ""
            currentOperation = operation
        }
    }
}

