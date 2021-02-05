//
//  ViewController.swift
//  Tipsy
//
//  Created by 2laa Ewis on 4/2/2021.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        // Dismiss the keyboard.
        if billTextField.isEditing {
            billTextField.endEditing(true)
        }
        
        // Deselect all tip buttons via IBOutlets.
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        // Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        // Remove the last character (%) from the title then turn it back to string.
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        
        // Turn string into double.
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        
        // Divide the percent expressed out of 100 into a decimal e.g 10 becomes 0.1
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Get the stepper value using sender.value, then set ia as the text in the splitNumberLabel.
        splitNumberLabel.text = Int(sender.value).description
        
        // Set the numberOfPeople property as the value of the stepper as a whole number.
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // Get the text the user typed in the billTextField.
        let bill = billTextField.text!
        
        // If the text not an empty string.
        if bill != "" {
            // Turn bill from string to double.
            billTotal = Double(bill)!
            
            // Multiply the bill by the tip precentage and divide by the number of people to split the bill.
            let result = billTotal * ( 1 + tip ) / Double(numberOfPeople)
            
            // Round the result to 2 decimal places and turn it into a String.
            finalResult = String(format: "%.2f", result)
            
            // Triggers the segue between CalculatorVC and ResultsVC
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // To diff between segue if you use more then one check segue identifier first.
        if segue.identifier == "goToResult" {
            // Get hold of instance of the desination view controller and type cast it to a ResultsViewController
            let desinationVC = segue.destination as! ResultsViewController
            
            // Set the destination ResultsViewController's properties values
            desinationVC.result = finalResult
            desinationVC.tip = Int(tip * 100)
            desinationVC.split = numberOfPeople
        }
    }
}
