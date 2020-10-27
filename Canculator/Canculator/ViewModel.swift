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
    
    // input
    func enterNumeral(numeral: Int, resultLabel: UILabel) {
        if self.calculation == "=" || resultLabel.text == "Infinity" {
            cancel()
            resultLabel.text = "0"
        }
        if isHasOperator == false && resultLabel.text != "0" {
            if resultLabel.text == "-0" {
                resultLabel.text?.remove(at: resultLabel.text?.index(before: resultLabel.text?.endIndex ?? "".endIndex) ?? "".endIndex)
                resultLabel.text?.append(String(numeral))
            } else {
                resultLabel.text?.append(String(numeral))
            }
        } else {
            resultLabel.text = String(numeral)
        }
    }
    
    func enterDecimol(resultLabel: UILabel) {
        var isHasDecimol = false
        for char in resultLabel.text ?? ""{
            if char == "." {
                isHasDecimol = true
            }
        }
        if !isHasDecimol {
            resultLabel.text?.append(".")
        }
    }
    
    func setNumInput(resultLbl: UILabel) {
        self.numInput = ((resultLbl.text ?? "0") as NSString).floatValue
    }
    
    func setNumbers(num: Float) {
        if isHasOperator {
            self.num2 = numInput
        } else {
            self.num1 = numInput
        }
        numInput = 0
    }
    
    // algorithm
    func sum() {
        num1 += num2
    }
    
    func subtract() {
        num1 -= num2
    }
    
    func product() {
        num1 = num1 * num2
    }
    
    func quotient(resultLabel: UILabel) {
        if num2 == 0 {
            resultLabel.text = "Infinity"
        } else {
            num1 /= num2
        }
    }
    
    func percent() {
        num1 /= 100
    }
    
    func equal() {
    }
    
    func absoluted(resultLabel: UILabel) {
        if resultLabel.text?.first == "-" {
            resultLabel.text?.remove(at: resultLabel.text?.startIndex ?? "".startIndex)
        } else {
            resultLabel.text = "-" + (resultLabel.text ?? "")
        }
        num1 = 0 - num1
    }
    
    // output
    func getResult(calculation: String, resultLabel: UILabel) {
        if isHasOperator == false {
            isHasOperator = true
            self.calculation = calculation
        } else {
            switch self.calculation {
            case "/":
                quotient(resultLabel: resultLabel)
            case "x":
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
    
    func showResult(resultLabel: UILabel) {
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
    
    func showCalculation(calculationLabel: UILabel) {
        calculationLabel.text = self.calculation
    }
    
    func clickAnOperatorButton(calculation: String, resultLabel: UILabel, calculationLabel: UILabel) {
        setNumInput(resultLbl: resultLabel)
        setNumbers(num: numInput)
        getResult(calculation: calculation, resultLabel: resultLabel)
        showResult(resultLabel: resultLabel)
        showCalculation(calculationLabel: calculationLabel)
    }
    
    func cancel() {
        num1 = 0
        num2 = 0
        numInput = 0
        isHasOperator = false
        calculation = ""
    }
    
}
