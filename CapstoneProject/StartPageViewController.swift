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
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil
			{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else
			{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    //var auth = firebase.auth();

    
    //auth.sendPasswordResetEmail(emailAddress).then(function()
    //{
    // Email sent.
    //}).catch(function(error)
    //{
    // An error happened.
    //});
    
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
