//
//  GameOverView.swift
//  FootballTrivia
//
//  Created by Liron Ezer on 21/05/2022.
//

import UIKit

class GameOverView: UIViewController {
    @IBOutlet weak var over_LBL_speech: UILabel!
    
    var player: String = ""
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 196/255, green: 221/255, blue: 255/255, alpha: 1)

        makeSpeech()
    }
    
    func makeSpeech() {
        over_LBL_speech.text = "Good job \(player)!\n You have scored \(score) points!\n Good luck on your next attemp!"
    }
    
    @IBAction func over_BTN_retry(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "home") as! HomeView
        present(vc, animated: true)
    }
    
}
