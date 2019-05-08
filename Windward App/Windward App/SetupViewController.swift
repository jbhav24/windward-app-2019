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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneWithPeriods(_ sender: Any) {
        if period1Text.text != "" && period2Text.text != "" && period3Text.text != "" && period4Text.text != "" && period5Text.text != "" && period6Text.text != "" && period7Text.text != "" && period8Text.text != "" {
            defaults.set(period1Text.text, forKey: "period1")
            defaults.set(period2Text.text, forKey: "period2")
            defaults.set(period3Text.text, forKey: "period3")
            defaults.set(period4Text.text, forKey: "period4")
            defaults.set(period5Text.text, forKey: "period5")
            defaults.set(period6Text.text, forKey: "period6")
            defaults.set(period7Text.text, forKey: "period7")
            defaults.set(period8Text.text, forKey: "period8")
            defaults.set(period9Text.text, forKey: "period9")
        }
    }
}
