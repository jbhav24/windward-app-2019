//
//  SetupViewController.swift
//  Windward App
//
//  Created by Jai on 5/7/19.
//  Copyright © 2019 Windward. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var period1Text: UITextField!
    @IBOutlet weak var period2Text: UITextField!
    @IBOutlet weak var period3Text: UITextField!
    @IBOutlet weak var period4Text: UITextField!
    @IBOutlet weak var period5Text: UITextField!
    @IBOutlet weak var period6Text: UITextField!
    @IBOutlet weak var period7Text: UITextField!
    @IBOutlet weak var period8Text: UITextField!
    @IBOutlet weak var period9Text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneWithPeriods(_ sender: Any) {
        
        if period1Text.text != "" && period2Text.text != "" && period3Text.text != "" && period4Text.text != "" && period5Text.text != "" && period6Text.text != "" && period7Text.text != "" && period8Text.text != "" {
            
        }
        
    }
}
