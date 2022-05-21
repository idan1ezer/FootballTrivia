//
//  ViewController.swift
//  FootballTrivia
//
//  Created by Liron Ezer on 17/05/2022.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var Home_TXT_Name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 196/255, green: 221/255, blue: 255/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Home_BTN_Start(_ sender: Any) {
        if (Home_TXT_Name.text == "") {
            Home_TXT_Name.text = "Player"
        }
            
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameView
        vc.player = Home_TXT_Name.text!
        //vc.initQuiz()
        present(vc, animated: true)
        
    }
    

}

