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

//import FirebaseStorage MARK: Need to install firebase storage

class ReportBullyingFormViewController: UIViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK Firebase Inits.
    
    var ref = Database.database().reference() //gets firebase connection
    let storage = Storage.storage() //firebase storage area

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
	
	@IBOutlet var ReportImageView: UIImageView!
	@IBOutlet var chooseButon: UIButton!
    
	var imagePicker = UIImagePickerController()
	
	@IBAction func uploadImage()
    {
		if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
			imagePicker.delegate = self
			imagePicker.sourceType = .savedPhotosAlbum
			imagePicker.allowsEditing = false
			
			present(imagePicker, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
		self.dismiss(animated: true, completion: { () -> Void in
			
		})
		
		ReportImageView.image = image
	}
    
    func uploadImageToDatabase()
    {
		if ReportImageView.image != nil
		{
			
		}
		else
		{
			return
		}
		
		let storageRef = storage.reference()
		
        // data = the picture selected by the user to upload
		let data = ReportImageView.image!.pngData()

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images")
        
        // Upload the file to the path "images"
		let uploadTask = riversRef.putData(data!, metadata: nil)
        { (metadata, error) in
		}
	}
    
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
		
        uploadImageToDatabase()
        
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
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer)
    {
        nameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary

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
