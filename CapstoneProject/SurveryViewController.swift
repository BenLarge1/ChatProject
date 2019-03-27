//
//  SurveryViewController.swift
//  CapstoneProject
//
//  Created by User on 3/26/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SurveyQuestion {
	//Variables
	var actualquestion: String = ""
	var answerOne: String = ""
	var answerTwo: String = ""
	var answerThree: String = ""
	var answerFour: String = ""
	
	//Methods
	
	
}

class SurveryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented") //why is this required? I don't know, but it is. Don't touch
	}
	
	var survey = [SurveyQuestion]()
	
	func fillQuestionArray() //fill the array of questions, this function runs when the app is first launched, and once a month to update the array
	{
		
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
