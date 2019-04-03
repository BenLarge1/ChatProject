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
	var actualquestion: String?
	var answerOne: String?
	var answerTwo: String?
	var answerThree: String?
	var answerFour: String?
	
	//Methods
	
	init()
	{
		actualquestion = ""
		answerOne = ""
		answerTwo = ""
		answerThree = ""
		answerFour = "" 
	}
}

class SurveryViewController: UIViewController {

    override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		enhanceUIElements()
		resetScreen()
		fillQuestionArray(completion: { message in
			
			self.updateScreenforNewQuestion()
		})
    }
    
    //MARK UI Elements
    
    @IBOutlet weak var actualQuestion: UILabel!
    @IBOutlet weak var optionOne: UILabel!
    @IBOutlet weak var optionTwo: UILabel!
    @IBOutlet weak var optionThree: UILabel!
    @IBOutlet weak var optionFour: UILabel!
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder) //why is this required? I don't know, but it is. Don't touch
	}
	
	var globalCounter = 0
	
	func enhanceUIElements()
	{
		let tapOne = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.answerOneSelected))
		optionOne.addGestureRecognizer(tapOne)
		
		let tapTwo = UITapGestureRecognizer(target:self, action: #selector(QuizViewController.answerTwoSelected))
		optionTwo.addGestureRecognizer(tapTwo)
		
		let tapThree = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.answerThreeSelected))
		optionThree.addGestureRecognizer(tapThree)
		
		let tapFour = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.answerFourSelected))
		optionFour.addGestureRecognizer(tapFour)
	}
	
	@objc func answerOneSelected() //father forgive me for this dumb code
	{

	}
	
	@objc func answerTwoSelected()
	{

	}
	
	@objc func answerThreeSelected()
	{

	}
	
	@objc func answerFourSelected()
	{

	}
	
	func disableButtons()
	{
		optionOne.isEnabled = false
		optionTwo.isEnabled = false
		optionThree.isEnabled = false
		optionFour.isEnabled = false
	}
	
	func enableButtons()
	{
		optionOne.isEnabled = true
		optionTwo.isEnabled = true
		optionThree.isEnabled = true
		optionFour.isEnabled = true
	}
	
	func resetScreen()
	{
		actualQuestion.text = ""
		optionOne.text = ""
		optionTwo.text = ""
		optionThree.text = ""
		optionFour.text = ""
		questionCount.text = "\(globalCounter + 1)/5"
		questionNumber.text = "Question \(globalCounter + 1)"
		optionOne.backgroundColor = UIColor.white
		optionTwo.backgroundColor = UIColor.white
		optionThree.backgroundColor = UIColor.white
		optionFour.backgroundColor = UIColor.white
		enableButtons()
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
	
	func updateScreenforNewQuestion()
	{
		if survey[0].actualquestion == nil
		{
			print("Array was not filled")
		}
		else if globalCounter >= 5
		{
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
			{ // Change `2.0` to the desired number of seconds.
				self.performSegue(withIdentifier: "quizToQuizEnd", sender: nil)
			}
		}
		else
		{
			resetScreen()
			actualQuestion.text = survey[globalCounter].actualquestion
			optionOne.text = survey[globalCounter].answerOne
			optionTwo.text = survey[globalCounter].answerTwo
			optionThree.text = survey[globalCounter].answerThree
			optionFour.text = survey[globalCounter].answerFour
			questionCount.text = "\(globalCounter + 1)/5"
			questionNumber.text = "Question \(globalCounter + 1)"
			
			/*
			if globalCounter > 3 //last question
			{
			submitButton.isEnabled = true
			submitButton.setTitle("Submit", for: .normal)
			submitButton.backgroundColor = .white
			}
			*/
			
			//globalCounter = 0
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
