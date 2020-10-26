//
//  ViewModel.swift
//  Canculator
//
//  Created by LTT on 10/23/20.
//

import Foundation
import UIKit

class ViewModel {
    private var num1: Float = 0
    private var num2: Float = 0
    private var numInput: Float = 0
    private var isHasOperator: Bool = false
    private var calculation: String = ""
    
    init() {
    }
    
    public func setNum1(num1: Float) {
        self.num1 = num1
    }
    public func getNum1() -> Float {
        return num1
    }
    
    public func setNum2(num2: Float) {
        self.num2 = num2
    }
    public func getNum2() -> Float {
        return num2
    }
    
    // input
    public func enterNumeral(_ numeral: Character, _ resultLabel: UILabel) {
        if self.calculation == "=" || resultLabel.text == "Infinity" {
            cancel()
            resultLabel.text = "0"
        }
        
        if numeral == "." {
            var isHasDot = false
            for character in resultLabel.text! {
                if character == numeral {
                    isHasDot = true
                }
            }
            if !isHasDot {
                resultLabel.text?.append(numeral)
            }
        } else {
            if isHasOperator == false && resultLabel.text != "0" {
                resultLabel.text!.append(numeral)
            } else {
                resultLabel.text = String(numeral)
            }
        }
    }
    
    public func setNumInput(_ resultLbl: UILabel) {
        self.numInput = (resultLbl.text! as NSString).floatValue
    }
    
    public func setNumbers(_ num: Float) {
        if isHasOperator {
            self.num2 = numInput
        } else {
            self.num1 = numInput
        }
        numInput = 0
    }
    
    // algorithm
    public func sum() {
        num1 += num2
    }
    
    public func subtract() {
        num1 -= num2
    }
    
    public func product() {
        num1 = num1 * num2
    }
    
    public func quotient(_ resultLabel: UILabel) {
        if num2 == 0 {
            resultLabel.text = "Infinity"
        } else {
            num1 /= num2
        }
    }
    
    public func equal() {
        calculation = "="
    }
    
    // output
    public func getResult(_ calculation: String, _ resultLabel: UILabel) {
        if isHasOperator == false {
            isHasOperator = true
            self.calculation = calculation
        } else {
            switch self.calculation {
            case "/":
                quotient(resultLabel)
            case "*":
                product()
            case "-":
                subtract()
            case "+":
                sum()
            default:
                equal()
            }
            self.calculation = calculation
        }
    }
    
    public func showResult(_ resultLabel: UILabel) {
        let num: Int = Int(num1)
        if resultLabel.text != "Infinity" {
            if num1 == Float(num) {
                resultLabel.text = String(format: "%.0f", num1)
            } else {
                resultLabel.text = String(num1)
            }
        } else {
            cancel()
        }
    }
    
    public func showCalculation(_ calculationLabel: UILabel) {
        calculationLabel.text = self.calculation
    }
    
    public func clickAnOperatorButton(_ calculation: String, _ resultLabel: UILabel, _ calculationLabel: UILabel) {
        self.setNumInput(resultLabel)
        self.setNumbers(numInput)
        self.getResult(calculation, resultLabel)
        self.showResult(resultLabel)
        self.showCalculation(calculationLabel)
    }
    
    public func cancel() {
        num1 = 0
        num2 = 0
        numInput = 0
        isHasOperator = false
        calculation = ""
    }
    
}
