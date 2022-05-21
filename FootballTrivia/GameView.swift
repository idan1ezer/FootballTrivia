//
//  GameView.swift
//  FootballTrivia
//
//  Created by Liron Ezer on 17/05/2022.
//

import UIKit

class GameView: UIViewController {
    
    var player: String = "Player"
    var questionsList = [Question]()
    
    let correctAnswers = [""]
    let photoLinks = [""]
    
    let wrongAnswers = ["Luka Modric", "John Charles", "Hugo Sanchez", "Jairzinho", "Omar Sivori", "Paolo Rossi", "Paul Breitner", "George Weah", "Kaka", "Lev Yashin", "Gunnar Nordahl", "Kevin Keegan", "Hristo Stoichkov", "Gianluigi Buffon", "Johan Neeskens", "Xavi Hernandez", "Luis Suarez", "Karl-Heinz Rummenigge", "Andres Iniesta", "Rivelino", "Bobby Moore", "Socrates", "Sandor Kocsis", "Lothar Matthaus", "Ronaldinho", "Ruud Gullit", "Bobby Charlton", "Giuseppe Meazza", "Raymond Kopa", "Romario", "Eusebio", "Marco van Basten", "George Best", "Zico", "Franco Baresi", "Cristiano Ronaldo", "Ferenc Puskas", "Paolo Maldini", "Gerd Muller", "Mane Garrincha", "Alfredo di Stefano", "Roberto Baggio", "Michel Platini", "Ronaldo", "Zinedine Zidane", "Johan Cruyff", "Franz Beckenbauer", "Lionel Messi", "Pele", "Diego Maradona", "Neymar", "Kylian Mbappe", "Karim Benzema", "Francesco Totti", "Alessandro Nesta"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 196/255, green: 221/255, blue: 255/255, alpha: 1)

        // Do any additional setup after loading the view.
    }
    
    func initQuiz() {
        for (answer, link) in zip(correctAnswers, photoLinks) {
            questionsList.append(Question(imageLink: link, answers: addPossibleAnswers(correct: answer)))
        }
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


}

struct Question {
    let imageLink: String
    let answers: [Answer]
}

struct Answer {
    let name: String
    let isTrue: Bool
}
