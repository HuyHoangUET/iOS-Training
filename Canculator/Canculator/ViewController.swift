//
//  ViewController.swift
//  Canculator
//
//  Created by LTT on 10/23/20.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - action
    // Operators
    @IBAction func cancelButton(_ sender: Any) {
        viewModel.cancel()
        viewModel.showResult(resultLabel)
        viewModel.showCalculation(calculationLabel)
    }
    @IBAction func absoluteButton(_ sender: Any) {
    }
    @IBAction func persentButton(_ sender: Any) {
        var num1 = Float(resultLabel.text!)
        num1! /= 100
        viewModel.setNum1(num1: num1!)
        viewModel.showResult(resultLabel)
    }
    @IBAction func devineButton(_ sender: Any) {
        viewModel.clickAnOperatorButton("/", resultLabel,calculationLabel)
    }
    @IBAction func multiplyButton(_ sender: Any) {
        viewModel.clickAnOperatorButton("*", resultLabel,calculationLabel)
    }
    @IBAction func minasButton(_ sender: Any) {
        viewModel.clickAnOperatorButton("-", resultLabel,calculationLabel)
    }
    @IBAction func plusButton(_ sender: Any) {
        viewModel.clickAnOperatorButton("+", resultLabel,calculationLabel)
    }
    @IBAction func equalButton(_ sender: Any) {
        viewModel.clickAnOperatorButton("=", resultLabel,calculationLabel)
    }
    @IBAction func decimolButton(_ sender: Any) {
        viewModel.enterNumeral(".", resultLabel)
    }
    
    // Numbers
    @IBAction func zeroButton(_ sender: Any) {
        viewModel.enterNumeral("0", resultLabel)
    }
    @IBAction func oneButton(_ sender: Any) {
        viewModel.enterNumeral("1", resultLabel)
    }
    @IBAction func twoButton(_ sender: Any) {
        viewModel.enterNumeral("2", resultLabel)
    }
    @IBAction func threeButton(_ sender: Any) {
        viewModel.enterNumeral("3", resultLabel)
    }
    @IBAction func fourButton(_ sender: Any) {
        viewModel.enterNumeral("4", resultLabel)
    }
    @IBAction func fiveButton(_ sender: Any) {
        viewModel.enterNumeral("5", resultLabel)
    }
    @IBAction func sixButton(_ sender: Any) {
        viewModel.enterNumeral("6", resultLabel)
    }
    @IBAction func sevenButton(_ sender: Any) {
        viewModel.enterNumeral("7", resultLabel)
    }
    @IBAction func eightButton(_ sender: Any) {
        viewModel.enterNumeral("8", resultLabel)
    }
    @IBAction func nineButton(_ sender: Any) {
        viewModel.enterNumeral("9", resultLabel)
    }
    
    // MARK: - outlet
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var ketBoardStackView: UIStackView!
    @IBOutlet weak var displayBodyView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
}

