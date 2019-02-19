//
//  StartPageViewController.swift
//  CapstoneProject
//
//  Created by User on 2/6/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StartPageViewController: UIViewController {

	//MARK Properties
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginToHome: UIButton!
    
    @IBAction func loginAction(_ sender: UIButton)
	{
		if self.emailTextField.text != "" && self.passwordTextField.text != ""
		{
        	Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil && error == nil
			{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else
			{
                let alertController = UIAlertController(title: "Error", message: "incorrect email or password, if new user please select new user", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        																						} //HEY LOOK AT ME
		}
		else
		{
			let alertController = UIAlertController(title: "Error", message: "shit is broke yo", preferredStyle: .alert)
			let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			alertController.addAction(defaultAction)
			self.present(alertController, animated: true, completion: nil)
		}
    }
	
    @IBAction func forgotPasswordTapped(_ sender: Any)
    {
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter email address"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil
                {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                else
                {
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }))
        //PRESENT ALERT
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    
    
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
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
