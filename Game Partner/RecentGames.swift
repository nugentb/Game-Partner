//
//  RecentGames.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/3/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RecentGames {
    struct GameData {
        var title: String
        var relDateString: String
        var gameID: String
    }
    
    
    var recentGameArray: [GameData] = []
    
    func getGames(completed: @escaping () -> () ) {
        var consoles: Consoles!
        consoles = Consoles()

        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.string(from: date)
        
        let monthsToAdd = -3
        var dateComponent = DateComponents()
        
        dateComponent.month = monthsToAdd
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: date)
        
        let futureDateString = formatter.string(from: futureDate!)
        
        print(date)
        print(futureDateString)
        
        var itemToAppend = "145"
        consoles.loadData {

            switch consoles.consoleArray[0].consoleName {
            case "Xbox One":
                itemToAppend = "145"
            case "PlayStation 4":
                itemToAppend = "146"
            case "Nintendo Switch":
                itemToAppend = "157"

            case "PC":
                itemToAppend = "94"

            case "PlayStation 3":
                itemToAppend = "35"

            case "Xbox 360":
                itemToAppend = "20"

            case "Wii U":
                itemToAppend = "94"

            case "Nintendo DS":
                itemToAppend = "52"

            default:
                itemToAppend = ""
            }
            
            let gamesURL = "https://www.giantbomb.com/api/games/?api_key=dfa758a5ce0f541751925d6104fe30cde783c507&field_list=name,guid,original_release_date&format=json&sort=original_release_date:desc&filter=original_release_date:\(futureDateString)%7C\(todayDate),platforms:\(itemToAppend)"
            
            // Trailing closure used below
            // Just change the URL if needed for different JSON API
            Alamofire.request(gamesURL).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let numberOfGames = json["results"].count
                    
                    for index in 0..<numberOfGames {
                        //Diving into the results array by index
                        let title: String
                        if (json["results"][index]["name"].string == nil) {
                            title = ""
                        }
                        else {
                            title = json["results"][index]["name"].stringValue
                        }
                        let relDateString: String
                        if (json["results"][index]["original_release_date"].string == nil) {
                            relDateString = ""
                        }
                        else {
                            relDateString = json["results"][index]["original_release_date"].stringValue
                        }
                        
                        
                        let gameID: String
                        
                        if (json["results"][index]["guid"].string == nil) {
                            gameID = ""
                        }
                        else {
                            gameID = json["results"][index]["guid"].stringValue
                        }
                        
                        let gameDataItem = GameData(title: title, relDateString: relDateString, gameID: gameID)
                        self.recentGameArray.append(gameDataItem)
                        print("\(title) \(relDateString) \(gameID)")
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription) failed to get data from URL \(gamesURL)")
                }
                completed()
                return
            }
            
        }

        

        

        
//        for item in consoles.consoleArray {
//            switch item.consoleName {
//            case "Xbox One":
//                let itemToAppend = "145"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "PlayStation 4":
//                let itemToAppend = "146"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "Nintendo Switch":
//                let itemToAppend = "157"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "PC":
//                let itemToAppend = "94"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "PlayStation 3":
//                let itemToAppend = "35"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "Xbox 360":
//                let itemToAppend = "20"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "Wii U":
//                let itemToAppend = "94"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            case "Nintendo DS":
//                let itemToAppend = "52"
//                if didAppend == 0 {
//                    URLAppend += itemToAppend
//                    didAppend = 1
//                    break
//                } else {
//                    URLAppend += ("," + itemToAppend)
//                }
//            default:
//                URLAppend = gamesURL + " "
//            }
//
//        }
        

    }
    
    
}
