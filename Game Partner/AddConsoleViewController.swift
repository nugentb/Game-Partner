//
//  AddConsoleViewController.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/2/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddConsoleViewController: UIViewController {

    var console: Console!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        console = Console()

        // Do any additional setup after loading the view.
    }
    
    var consolesToPick = ["Xbox One", "PlayStation 4",  "Nintendo Switch", "PC", "PlayStation 3", "Xbox 360", "Wii U", "Nintendo DS"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let outputValue = consolesToPick[pickerView.selectedRow(inComponent: 0)]
        
        console.consoleName = outputValue
        
        console.saveData { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("ERROR SAVING DATA IN ADDCONSOLEVIEWCONTROLLER")
            }
        }
        print("\(outputValue)")
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddConsoleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return consolesToPick.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return consolesToPick[row]
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        conversionString = formulasArray[row].conversionString
//
//        if conversionString.contains("celsius") {
//            signSegment.isHidden = false
//        } else {
//            signSegment.isHidden = true
//            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
//            signSegment.selectedSegmentIndex = 0
//        }
//
//        resultsLabel.text = toUnits
//        calculateConversion()
//    }
}
