

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var questionsCorrect = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
  
    }
    
    func updateUI() {
        
         if questionNumber < allQuestions.list.count {
            progressLabel.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
        }
        
        scoreLabel.text = "Score: \(questionsCorrect)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber)

    }
    func nextQuestion() {
        updateUI()
        if questionNumber < allQuestions.list.count {
            questionLabel.text = allQuestions.list[questionNumber].questionText
        } else {
            let quizFinished = UIAlertController(title: "Quizzer", message: "You Finished the Quiz!", preferredStyle: .alert)
            
            let restartQuiz = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
                
            })
            
            quizFinished.addAction((restartQuiz))
            present(quizFinished, animated: true)
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            questionsCorrect += 1
        } else {
            ProgressHUD.showError("Incorrect")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        questionsCorrect = 0
        nextQuestion()
    }
    

    
}
