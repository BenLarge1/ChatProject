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
    
    //MARK Variables
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func createUserAccount(_ sender: UIButton)
    {
        if emailTextField != nil && passwordTextField != nil && confirmPasswordTextField != nil && passwordTextField.text == confirmPasswordTextField.text
        {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {authResult, error in
			if error == nil
			{
				Auth.auth().currentUser?.sendEmailVerification { (error) in
					if error != nil
					{
						let alertController = UIAlertController(title: "Error", message: "could not send email verification, unknown error (need to impliment error getting", preferredStyle: .alert)
						let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
						
						alertController.addAction(defaultAction)
						self.present(alertController, animated: true, completion: nil)
					}
				
				self.performSegue(withIdentifier: "signupToHome", sender: self)
																}
			}
			else
			{
				let alertController = UIAlertController(title: "Error", message: "could not create user, check to make sure you are using a valid email address", preferredStyle: .alert)
				let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
				
				alertController.addAction(defaultAction)
				self.present(alertController, animated: true, completion: nil)
			}
        																								} //HEY LOOK AT ME
		}
        else
        {
			let alertController = UIAlertController(title: "Error", message: "could not create user, check to make sure you have filled out all fields, or that your password matches the confirm password field", preferredStyle: .alert)
			let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			
			alertController.addAction(defaultAction)
			self.present(alertController, animated: true, completion: nil)
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
