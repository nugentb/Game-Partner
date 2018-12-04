//
//  GameDetailsViewController.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/3/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit

class GameDetailsViewController: UIViewController {

    var gameID: String = ""
    var gameURL = ""
    var gameToDisplay = Game()
    var gameToSave = GameToSave()
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameReleaseLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameURL = "https://www.giantbomb.com/api/game/\(self.gameID)/?api_key=dfa758a5ce0f541751925d6104fe30cde783c507&format=json"
        
        gameToDisplay.gameURL = gameURL
        
        print(gameID)
        
        gameToDisplay.getGame {
            print(self.gameToDisplay.title)
            print(self.gameToDisplay.relDateString)
            self.gameTitleLabel.text = self.gameToDisplay.title
            
            var textToFormat = self.gameToDisplay.relDateString
            let output = "\(textToFormat[5 ..< 7]) \(textToFormat[8 ..< 10]) \(textToFormat[0 ..< 4])"
            
            self.gameReleaseLabel.text = output
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addToMyGamesButtonPressed(_ sender: UIButton) {
        
        
        gameToSave.title = self.gameToDisplay.title
        gameToSave.gameID = gameID
        gameToSave.releaseDate = self.gameToDisplay.relDateString
        
        gameToSave.saveData { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("ERROR SAVING DATA IN GameDetailsVC")
            }
        }
        print("Save in GameDetailsVC was a success")
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}



