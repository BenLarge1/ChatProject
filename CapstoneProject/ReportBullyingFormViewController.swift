//
//  ReportBullyingFormViewController.swift
//  CapstoneProject
//
//  Created by User on 2/21/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseDatabase

//import FirebaseStorage MARK: Need to install firebase storage

class ReportBullyingFormViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var ref = Database.database().reference()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var anonSwitch: UISwitch!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func toggleSwitch(_ sender: UISwitch)
    {
        if anonSwitch.isOn
        {
            nameTextField.isUserInteractionEnabled = false
			nameTextField.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
			nameTextField.textColor = #colorLiteral(red: 0.2470588235, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
			nameTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        else
        {
            nameTextField.isUserInteractionEnabled = true
			nameTextField.backgroundColor = UIColor.white
			nameTextField.textColor = UIColor.black
			nameTextField.attributedPlaceholder = NSAttributedString(string: "Your Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        }
    }
	@IBOutlet weak var reportDescriptionTextView: UITextView!;
	
	let user = Auth.auth().currentUser

	@IBAction func writeReportToDatabase(_ sender: UIButton) //writes their name (if applicable), date, and description to database
    {
		
		let key = ref.child("posts").childByAutoId().key
		let post = ["report": reportDescriptionTextView.text as String?,
					"name": nameTextField.text as String?,
					"date": dateTextField.text as String?,
					"uid": user?.uid as String?]
		let childUpdates = ["/reports/\(String(describing: key))": post]
		ref.updateChildValues(childUpdates)
		
		sendEmail()
    }
    
    func sendEmail()
	{
		let mailComposeViewController = configureMailController()
		if MFMailComposeViewController.canSendMail()
		{
			self.present(mailComposeViewController, animated: true, completion: nil)
		}
		else
		{
			showMailError()
		}
	}
	
	func configureMailController() -> MFMailComposeViewController
	{
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		
		mailComposerVC.setToRecipients(["wildcatsagainstbullying@gmail.com"])
		mailComposerVC.setSubject("New Report From:" + (user?.uid)!)
		mailComposerVC.setMessageBody("Report message\n" + reportDescriptionTextView.text, isHTML: false)
		
		return mailComposerVC
	}
	
	func showMailError()
	{
		let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device may not be able to send email, or you are running this from a simulator", preferredStyle: .alert)
		let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
		sendMailErrorAlert.addAction(dismiss)
		self.present(sendMailErrorAlert, animated: true, completion: nil)
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
	{
		controller.dismiss(animated: true, completion: nil)
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
