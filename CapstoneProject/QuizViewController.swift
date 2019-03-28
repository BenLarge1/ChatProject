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
		fillQuestionArray()
		updateScreenForStartingQuiz()
		enhanceUIElements()
		
	}
	var globalCounter = 0
	
	func updateScreenForStartingQuiz()
	{
		actualQuestion.text = ""
		answerOnePlace.text = ""
		answerTwoPlace.text = ""
		answerThreePlace.text = ""
		answerFourPlace.text = ""
		placeInQuizIncrementor.text = "\(globalCounter)/5"
		questionIdentifier.text = "Question \(globalCounter)"
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
	
	func fillQuestionArray() //fill the array of questions, this function runs when the app is first launched, and once a month to update the array
	{
		//detect if it's a new month
		
		var ref: DatabaseReference!
		ref = Database.database().reference()
		
		var placeKeeping = ""
		
		for i in 1...10{
		
			switch i {
			case 1:
				placeKeeping = "questionOne"
			case 2:
				placeKeeping = "questionTwo"
			case 3:
				placeKeeping = "questionThree"
			case 4:
				placeKeeping = "questionFour"
			case 5:
				placeKeeping = "questionFive"
			case 6:
				placeKeeping = "questionSix"
			case 7:
				placeKeeping = "questionSeven"
			case 8:
				placeKeeping = "questionEight"
			case 9:
				placeKeeping = "questionNine"
			case 10:
				placeKeeping = "questionTen"
			default:
				print("Error in switch case, no matching cases found")
			}
			
			
		ref.child("quizzes").child(nameOfMonth).child(placeKeeping).observeSingleEvent(of: .value, with: { (snapshot) in
			
		let value = snapshot.value as? NSDictionary
		
		let question = QuizQuestion()
		question.actualquestion = value?["actualQuestion"] as? String ?? ""
		question.optionOne = value?["optionOne"] as? String ?? ""
		question.optionTwo = value?["optionTwo"] as? String ?? ""
		question.optionThree = value?["optionThree"] as? String ?? ""
		question.optionFour = value?["optionFour"] as? String ?? ""
		question.correctAnswer = value?["correctAnswer"] as? String ?? ""
		
		self.quiz.append(question)
			})
					}
	}
	
	@objc func answerOneSelected() //father forgive me for this dumb code
	{
		if answerOnePlace.text == quiz[globalCounter].correctAnswer
		{
			answerOnePlace.backgroundColor = UIColor.green
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
			{ // Change `2.0` to the desired number of seconds.
				self.globalCounter += 1
				self.updateScrenforNewQuestion()
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
				self.updateScrenforNewQuestion()
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
				self.updateScrenforNewQuestion()
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
				self.updateScrenforNewQuestion()
			}
		}
		else
		{
			answerFourPlace.backgroundColor = UIColor.red
		}
	}
	
	
	func updateScrenforNewQuestion()
	{
		actualQuestion.text = quiz[globalCounter].actualquestion
		answerOnePlace.text = quiz[globalCounter].optionOne
		answerTwoPlace.text = quiz[globalCounter].optionTwo
		answerThreePlace.text = quiz[globalCounter].optionThree
		answerFourPlace.text = quiz[globalCounter].optionFour
		placeInQuizIncrementor.text = "1/5"
		questionIdentifier.text = "Question \(globalCounter)"
		
		if globalCounter >= 4 //last question
		{
			submitButton.isEnabled = true
			submitButton.setTitle("See Results", for: .normal) //remove text from button
			submitButton.backgroundColor = .blue
		}
		
		//globalCounter = 0
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
