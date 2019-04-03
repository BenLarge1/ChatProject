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
    
    //MARK UI Elements
    
    @IBOutlet weak var actualQuestion: UILabel!
    @IBOutlet weak var optionOne: UILabel!
    @IBOutlet weak var optionTwo: UILabel!
    @IBOutlet weak var optionThree: UILabel!
    @IBOutlet weak var optionFour: UILabel!
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented") //why is this required? I don't know, but it is. Don't touch
	}
	
	var survey = [SurveyQuestion]()
	
	func getTheMonth() -> String
	{
		let now = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "es")
		dateFormatter.dateFormat = "LLLL"
		let nameOfMonth = dateFormatter.string(from: now)
		
		return nameOfMonth
	}
	
	lazy var nameOfMonth = getTheMonth()
	
	func fillQuestionArray(completion: @escaping (_ message: String) -> Void) //fill the array of questions, this function runs when the app is first launched, and once a month to update the array
	{
		//detect if it's a new month
		
		var ref: DatabaseReference!
		ref = Database.database().reference()
		ref.child("surveys").child(nameOfMonth.lowercased()).observeSingleEvent(of: .value, with: { (snapshot) in
			
			for item in snapshot.children.allObjects as! [DataSnapshot] {
				let value = item.value as! NSDictionary
				
				let tempQuestion = SurveyQuestion()
				tempQuestion.actualquestion = value["actualQuestion"] as? String ?? "Did Not Receive Data"
				tempQuestion.answerOne = value["optionOne"] as? String ?? "Did Not Receive Data"
				tempQuestion.answerTwo = value["optionTwo"] as? String ?? "Did Not Receive Data"
				tempQuestion.answerThree = value["optionThree"] as? String ?? "Did Not Receive Data"
				tempQuestion.answerFour = value["optionFour"] as? String ?? "Did Not Receive Data"
				
				self.survey.append(tempQuestion) //ADD OBJECT TO ARRAY
				self.survey.shuffle()
			}
			completion("DONE")
		})
		
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
