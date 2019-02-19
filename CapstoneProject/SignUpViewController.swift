//
//  SignUpViewController.swift
//  CapstoneProject
//
//  Created by User on 2/18/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func createUserAccount(_ sender: UIButton)
    {
        if emailTextField != nil && passwordTextField != nil && confirmPasswordTextField != nil && passwordTextField.text == confirmPasswordTextField.text
        {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {authResult, error in}
            
            
        }
        else
        {
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
