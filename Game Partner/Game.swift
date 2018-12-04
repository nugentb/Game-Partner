//
//  Game.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/3/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Game {
    var title = ""
    var relDateString = ""
    var imageURL = ""
    var description = ""
    var gameURL = ""
    
    func getGame(completed: @escaping () -> () ) {
        
        // Trailing closure used below
        // Just change the URL if needed for different JSON API
        print("I AM HERE")
        print(gameURL)
        Alamofire.request(gameURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("I AM HERE 2")
                let json = JSON(value)
                self.title = json["results"]["name"].stringValue
                self.relDateString = json["results"]["original_release_date"].stringValue
                self.imageURL = json["results"]["image"]["medium_url"].stringValue
                self.description = json["results"]["description"].stringValue
                
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from URL \(self.gameURL)")
            }
            completed()
        }
    }
}

