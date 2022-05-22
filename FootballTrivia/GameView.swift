//
//  GameView.swift
//  FootballTrivia
//
//  Created by Liron Ezer on 17/05/2022.
//

import UIKit
import Kingfisher

class GameView: UIViewController {
    
    @IBOutlet weak var game_IMG_image: UIImageView!
    @IBOutlet weak var game_BAR_progres: UIProgressView!
    @IBOutlet weak var game_IMG_heart1: UIImageView!
    @IBOutlet weak var game_IMG_heart2: UIImageView!
    @IBOutlet weak var game_IMG_heart3: UIImageView!
    @IBOutlet weak var game_LBL_score: UILabel!
    
    @IBOutlet weak var game_BTN_ans1: UIButton!
    @IBOutlet weak var game_BTN_ans2: UIButton!
    @IBOutlet weak var game_BTN_ans3: UIButton!
    @IBOutlet weak var game_BTN_ans4: UIButton!
    
    //var btns: Array<UIButton> = [game_BTN_ans1, game_BTN_ans]
    //var hearts: Array<UIImageView> = [game_IMG_heart1, game_IMG_heart2, game_IMG_heart3]
    
    var player: String = "Player"
    var score: Int = 0
    var mistakes: Int = 0
    var qIndex: Int = 0
    var questionsList = [Question]()
    
    let correctAnswers = ["Sergio Aguero", "Gianluigi Buffon", "Cristiano Ronaldo", "Andres Iniesta", "Kevin De Bruyne", "Paolo Maldini", "Diego Maradona", "Kylian Mbappe", "Lionel Messi", "Manuel Neur", "Neymar", "Carles Puyol", "Ronaldo", "David Villa", "Zinedine Zidane"]
    
    let photoLinks = ["https://i.ibb.co/cvNpsYq/aguero.jpg",
                    "https://i.ibb.co/CJsyyJL/buffon.jpg",
                    "https://i.ibb.co/MGpyVFx/cristiano.jpg",
                    "https://i.ibb.co/rQgrX5b/iniesta.jpg",
                    "https://i.ibb.co/z4hCrXr/kdb.jpg",
                    "https://i.ibb.co/qmN3QSK/maldini.jpg",
                    "https://i.ibb.co/2M2Jjs7/maradona.jpg",
                    "https://i.ibb.co/rs5HJcD/mbappe.jpg",
                    "https://i.ibb.co/zZTSXry/messi.jpg",
                    "https://i.ibb.co/LR7XtDt/neur.jpg",
                    "https://i.ibb.co/jHxSDmj/neymar.jpg",
                    "https://i.ibb.co/gyQ8L0h/puyol.jpg",
                    "https://i.ibb.co/xHB9dck/r9.jpg",
                    "https://i.ibb.co/cvGcsdf/villa.jpg",
                    "https://i.ibb.co/7G9Xd3C/zidane.jpg"]
    
    let wrongAnswers = ["Luka Modric", "John Charles", "Hugo Sanchez", "Jairzinho", "Omar Sivori", "Paolo Rossi", "Paul Breitner", "George Weah", "Kaka", "Lev Yashin", "Gunnar Nordahl", "Kevin Keegan", "Hristo Stoichkov", "Johan Neeskens", "Xavi Hernandez", "Luis Suarez", "Karl-Heinz Rummenigge",  "Rivelino", "Bobby Moore", "Socrates", "Sandor Kocsis", "Lothar Matthaus", "Ronaldinho", "Ruud Gullit", "Bobby Charlton", "Giuseppe Meazza", "Raymond Kopa", "Romario", "Eusebio", "Marco van Basten", "George Best", "Zico", "Franco Baresi", "Ferenc Puskas", "Gerd Muller", "Mane Garrincha", "Alfredo di Stefano", "Roberto Baggio", "Michel Platini", "Johan Cruyff", "Franz Beckenbauer", "Pele", "Karim Benzema", "Francesco Totti", "Alessandro Nesta"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 196/255, green: 221/255, blue: 255/255, alpha: 1)

        initQuiz()
    }
    
    func initQuiz() {
        for (answer, link) in zip(correctAnswers, photoLinks) {
            questionsList.append(Question(imageLink: link, answers: addPossibleAnswers(correct: answer)))
        }
        loadQuestion(question: questionsList[qIndex])
    }
    
    func addPossibleAnswers(correct: String) -> Array<Answer> {
        let tempWrong = randomAnswers()
        
        var answers = [Answer]()
        for player in tempWrong {
            answers.append(Answer(name: player, isTrue: false))
        }
        answers.append(Answer(name: correct, isTrue: true))
        answers.shuffle()
        
        return answers
    }
    
    private func randomAnswers() -> Array<String> {
        var resultSet = Set<String>()
        
        while resultSet.count < 3 {
            let randomIndex = Int(arc4random_uniform(UInt32(wrongAnswers.count)))
            resultSet.insert(wrongAnswers[randomIndex])
        }
        
        return Array(resultSet)
    }
    
    func loadQuestion(question: Question) {
        game_BTN_ans1.setTitle(question.answers[0].name, for: .normal)
        game_BTN_ans2.setTitle(question.answers[1].name, for: .normal)
        game_BTN_ans3.setTitle(question.answers[2].name, for: .normal)
        game_BTN_ans4.setTitle(question.answers[3].name, for: .normal)
        
        let uri = URL(string: question.imageLink)!
        game_IMG_image.kf.setImage(with: uri)
        
        qIndex += 1
    }
    
    func checkAnswer(question: Question, player: String) -> Bool {
        if question.answers.contains(where: { $0.name == player && $0.isTrue}) {
            score += 50
            updateScore()
            return true
        }
        else {
            score -= 10
            mistakes += 1
            updateScore()
            return false
        }
    }
    
    func updateScore() {
        game_LBL_score.text = ("\(score)")
    }
    
    func colorAns(index: Int) {
        switch index {
        case 1:
            game_BTN_ans1.backgroundColor = UIColor.green
            game_BTN_ans2.backgroundColor = UIColor.red
            game_BTN_ans3.backgroundColor = UIColor.red
            game_BTN_ans4.backgroundColor = UIColor.red
        case 2:
            game_BTN_ans1.backgroundColor = UIColor.red
            game_BTN_ans2.backgroundColor = UIColor.green
            game_BTN_ans3.backgroundColor = UIColor.red
            game_BTN_ans4.backgroundColor = UIColor.red
        case 3:
            game_BTN_ans1.backgroundColor = UIColor.red
            game_BTN_ans2.backgroundColor = UIColor.red
            game_BTN_ans3.backgroundColor = UIColor.green
            game_BTN_ans4.backgroundColor = UIColor.red
        case 4:
            game_BTN_ans1.backgroundColor = UIColor.red
            game_BTN_ans2.backgroundColor = UIColor.red
            game_BTN_ans3.backgroundColor = UIColor.red
            game_BTN_ans4.backgroundColor = UIColor.green
        default:
            break
        }
    }
    
    func checkGameOver() {
        if qIndex < 15 && mistakes < 3 {
            loadQuestion(question: questionsList[qIndex])
            removeCol()
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "gameover") as! GameOverView
            vc.player = player
            vc.score = score
            present(vc, animated: true)
        }
    }
    
    func removeCol() {
        game_BTN_ans1.backgroundColor = nil
        game_BTN_ans2.backgroundColor = nil
        game_BTN_ans3.backgroundColor = nil
        game_BTN_ans4.backgroundColor = nil
    }
    
    @IBAction func game_BTN_ans1(_ sender: Any) {
        if (checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans1.currentTitle!)) {
            colorAns(index: 1)
        }
        checkGameOver()
    }
    
    @IBAction func game_BTN_ans2(_ sender: Any) {
        if (checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans2.currentTitle!)) {
            colorAns(index: 2)
        }
        checkGameOver()
    }
    
    @IBAction func game_BTN_ans3(_ sender: Any) {
        if (checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans3.currentTitle!)) {
            colorAns(index: 3)
        }
        checkGameOver()
    }
    
    @IBAction func game_BTN_ans4(_ sender: Any) {
        if (checkAnswer(question: questionsList[qIndex-1], player: game_BTN_ans4.currentTitle!)) {
            colorAns(index: 4)
        }
        checkGameOver()
    }
}

struct Question {
    let imageLink: String
    let answers: [Answer]
}

struct Answer {
    let name: String
    let isTrue: Bool
}
