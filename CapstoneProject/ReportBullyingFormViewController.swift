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
import FirebaseStorage
import Foundation

class ReportBullyingFormViewController: UIViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK Firebase Inits.
    
    var ref = Database.database().reference() //gets firebase connection
    let storage = Storage.storage() //firebase storage area
	
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let selectedImage = info[.originalImage] as? UIImage else
        {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        reportImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
		let storageRef = storage.reference() //reusable reference to image locations
    }
    
    //MARK Variables #0
    
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
            nameTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        else
        {
            nameTextField.isUserInteractionEnabled = true
			nameTextField.backgroundColor = UIColor.white
			nameTextField.textColor = UIColor.black
            nameTextField.attributedPlaceholder = NSAttributedString(string: "Your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
	@IBOutlet weak var reportDescriptionTextView: UITextView!;
	
	//MARK Variables #1
	
	let user = Auth.auth().currentUser
	
<<<<<<< HEAD
	@IBOutlet var ReportImageView: UIImageView!
	//@IBOutlet var chooseButon: UIButton!
	
	@IBAction func writeReportToDatabase(_ sender: UIButton) //writes their name (if applicable), date, and description to database
    {
		
=======
	@IBOutlet var reportImageView: UIImageView!
	
    @IBAction func addImageToImageView(_ sender: Any)
    {
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        reportDescriptionTextView.resignFirstResponder() //if the user selects "upload image" while still having the keyboard open from any text field, this will minimize it
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func uploadImageToFirebase(_ image:UIImage)
	{
		let storageRef = Storage.storage().reference().child("reportImages")
        let imgData = reportImageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metaData, error ) in
            if error == nil
            {
                print("Success")
            }
            else
            {
                print("error in uploading image to firebase")
            }
        }
        
    }
    
	@IBAction func writeReportToDatabase(_ sender: UIButton) //writes their name (if applicable), date, and description to database
    {
		if reportDescriptionTextView.text == nil
		{
			let alertController = UIAlertController(title: "Error", message: "Please include a description before submitting", preferredStyle: .alert)
			let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			
			alertController.addAction(defaultAction)
			self.present(alertController, animated: true, completion: nil)
		}
		else
		{
>>>>>>> master
		let key = ref.child("posts").childByAutoId().key
		let post = ["report": reportDescriptionTextView.text as String?,
					"name": nameTextField.text as String?,
					"date": dateTextField.text as String?,
					"uid": user?.uid as String?]
		let childUpdates = ["/reports/\(String(describing: key))": post]
		ref.updateChildValues(childUpdates)
        
        if reportImageView.image == nil
        {
            uploadImageToFirebase(reportImageView.image!)
        }
            
		sendEmail()
		}
		
		
        
		let alertController = UIAlertController(title: "Success!", message: "Thank you! Your submission has been received and a faculty member will respond as soon as possible. In the mean time, here are some useful resources.", preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in self.GoToResourcesPages()})
		
		alertController.addAction(defaultAction)
		self.present(alertController, animated: true, completion: nil)
		
    }
	
	func GoToResourcesPages() //just calls transition to resources page
	{
		performSegue(withIdentifier: "reportToResources", sender: self)
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
    
    /* @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer)
    {
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary

    } */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
