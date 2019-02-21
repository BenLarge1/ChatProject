//
//  ReportBullyingFormViewController.swift
//  CapstoneProject
//
//  Created by User on 2/21/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ReportBullyingFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var anonSwitch: UISwitch!
    @IBAction func toggleSwitch(_ sender: UISwitch)
    {
        if anonSwitch.isOn
        {
            nameTextField.isUserInteractionEnabled = false
			
        }
        else
        {
            nameTextField.isUserInteractionEnabled = true

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
