//
//  ViewController.swift
//  Canculator
//
//  Created by LTT on 10/23/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var keyboardStackView: UIStackView!
    @IBOutlet weak var displayBodyView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!

    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayBodyView.layer.cornerRadius = 5
        displayBodyView.layer.borderWidth = 1
    }
    
    //MARK: - action
    @IBAction func cancelButton(_ sender: Any) {
        viewModel.cancel()
        resultLabel.text = ""
        calculationLabel.text = ""
        viewModel.showResult(resultLabel: resultLabel)
        viewModel.showCalculation(calculationLabel: calculationLabel)
    }
    
    // Operators
    @IBAction func operatorButton(_ sender: UIButton) {
        viewModel.clickAnOperatorButton(calculation: sender.currentTitle ?? "", resultLabel: resultLabel, calculationLabel: calculationLabel)
    }
    
    @IBAction func persentButton(_ sender: Any) {
        viewModel.percent()
        viewModel.showResult(resultLabel: resultLabel)
    }
    
    @IBAction func absoluteButton(_ sender: Any) {
        viewModel.absoluted(resultLabel: resultLabel)
    }
    
    // Numbers
    @IBAction func numberButton(_ sender: UIButton) {
        for numberTag in 0...9 {
            if sender.tag == numberTag {
                viewModel.enterNumeral(numeral: numberTag, resultLabel: resultLabel)
            }
        }
    }
    
    
    @IBAction func decimolButton(_ sender: Any) {
        viewModel.enterDecimol(resultLabel: resultLabel)
    }
}

