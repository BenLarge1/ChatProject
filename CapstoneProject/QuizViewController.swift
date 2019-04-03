//
//  QuizViewController.swift
//  CapstoneProject
//
//  Created by User on 3/27/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class QuizQuestion
{
	//Variables
	var actualquestion: String?
	var optionOne: String?
	var optionTwo: String?
	var optionThree: String?
	var optionFour: String?
	var correctAnswer: String?
	
	//Methods
	
	init()
	{
		actualquestion = ""
		optionOne = ""
		optionTwo = ""
		optionThree = ""
		optionFour = ""
		correctAnswer = ""
	}
}

class QuizViewController: UIViewController
{
	
	//UI Elements
    @IBOutlet weak var actualQuestion: UILabel!
    @IBOutlet weak var answerOnePlace: UILabel!
    @IBOutlet weak var answerTwoPlace: UILabel!
    @IBOutlet weak var answerThreePlace: UILabel!
    @IBOutlet weak var answerFourPlace: UILabel!
    @IBOutlet weak var placeInQuizIncrementor: UILabel!
    @IBOutlet weak var questionIdentifier: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
	
	func enhanceUIElements()
	{
		let tapOne = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.answerOneSelected))
		answerOnePlace.addGestureRecognizer(tapOne)
		
		let tapTwo = UITapGestureRecognizer(target:self, action: #selector(QuizViewController.answerTwoSelected))
		answerTwoPlace.addGestureRecognizer(tapTwo)
		
		let tapThree = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.answerThreeSelected))
		answerThreePlace.addGestureRecognizer(tapThree)
		
		let tapFour = UITapGestureRecognizer(target: self, action: #selector(QuizViewController.answerFourSelected))
		answerFourPlace.addGestureRecognizer(tapFour)
	}
	
    override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		enhanceUIElements()
		updateScreenForStartingQuiz()
		fillQuestionArray(completion: { message in
			
			self.updateScreenforNewQuestion()
		})
	}
	
	var globalCounter = 0
	//var globalQuestionsCorrect = 0
	
	func updateScreenForStartingQuiz()
	{
		actualQuestion.text = ""
		answerOnePlace.text = ""
		answerTwoPlace.text = ""
		answerThreePlace.text = ""
		answerFourPlace.text = ""
		placeInQuizIncrementor.text = "\(globalCounter + 1)/5"
		questionIdentifier.text = "Question \(globalCounter + 1)"
		submitButton.isEnabled = false
		submitButton.setTitle("", for: .normal) //remove text from button
		submitButton.backgroundColor = .clear
		globalCounter = 0
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder) //why is this required? I don't know, but it is. Don't touch
		//var globalCounter: Int
	}
	
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
	
	var quiz = [QuizQuestion]()
	
	func fillQuestionArray(completion: @escaping (_ message: String) -> Void) //fill the array of questions, this function runs when the app is first launched, and once a month to update the array
	{
		//detect if it's a new month
		
		var ref: DatabaseReference!
		ref = Database.database().reference()
		ref.child("quizzes").child("january").observeSingleEvent(of: .value, with: { (snapshot) in
			
				for item in snapshot.children.allObjects as! [DataSnapshot] {
					let value = item.value as! NSDictionary
					
					let tempQuestion = QuizQuestion()
					tempQuestion.actualquestion = value["actualQuestion"] as? String ?? "Did Not Receive Data"
					tempQuestion.optionOne = value["optionOne"] as? String ?? "Did Not Receive Data"
					tempQuestion.optionTwo = value["optionTwo"] as? String ?? "Did Not Receive Data"
					tempQuestion.optionThree = value["optionThree"] as? String ?? "Did Not Receive Data"
					tempQuestion.optionFour = value["optionFour"] as? String ?? "Did Not Receive Data"
					tempQuestion.correctAnswer = value["correctAnswer"] as? String ?? "Did Not Receive Data"
					
					self.quiz.append(tempQuestion) //ADD OBJECT TO ARRAY
					self.quiz.shuffle()
				}
			completion("DONE")
			})
		
	}
	
	@objc func answerOneSelected() //father forgive me for this dumb code
	{
		if answerOnePlace.text == quiz[globalCounter].correctAnswer
		{
			answerOnePlace.backgroundColor = UIColor.green
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
			{ // Change `2.0` to the desired number of seconds.
				self.globalCounter += 1
				self.updateScreenforNewQuestion()
			}
		}
		else
		{
			answerOnePlace.backgroundColor = UIColor.red
		}
	}
	
	@objc func answerTwoSelected()
	{
		if answerTwoPlace.text == quiz[globalCounter].correctAnswer
		{
			answerTwoPlace.backgroundColor = UIColor.green
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
			{ // Change `2.0` to the desired number of seconds.
				self.globalCounter += 1
				self.updateScreenforNewQuestion()
			}
		}
		else
		{
			answerTwoPlace.backgroundColor = UIColor.red
		}
	}
	
	@objc func answerThreeSelected()
	{
		if answerThreePlace.text == quiz[globalCounter].correctAnswer
		{
			answerThreePlace.backgroundColor = UIColor.green
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
			{ // Change `2.0` to the desired number of seconds.
				self.globalCounter += 1
				self.updateScreenforNewQuestion()
			}
		}
		else
		{
			answerThreePlace.backgroundColor = UIColor.red
		}
	}
	
	@objc func answerFourSelected()
	{
		if answerFourPlace.text == quiz[globalCounter].correctAnswer
		{
			answerFourPlace.backgroundColor = UIColor.green
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
			{ // Change `2.0` to the desired number of seconds.
				self.globalCounter += 1
				self.updateScreenforNewQuestion()
			}
		}
		else
		{
			answerFourPlace.backgroundColor = UIColor.red
		}
	}
	
	
	func updateScreenforNewQuestion()
	{
		if quiz[0].actualquestion == nil
		{
			print("Array was not filled")
		}
		else{
		actualQuestion.text = quiz[globalCounter].actualquestion
		answerOnePlace.text = quiz[globalCounter].optionOne
		answerTwoPlace.text = quiz[globalCounter].optionTwo
		answerThreePlace.text = quiz[globalCounter].optionThree
		answerFourPlace.text = quiz[globalCounter].optionFour
		placeInQuizIncrementor.text = "\(globalCounter + 1)/5"
		questionIdentifier.text = "Question \(globalCounter + 1)"
		
		if globalCounter > 4 //last question
		{
			submitButton.isEnabled = true
			submitButton.setTitle("Submit", for: .normal)
			submitButton.backgroundColor = .white
		}
		
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
