//
//  GamesSaved.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/3/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class GamesSaved {
    var gameArray = [GameToSave]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("games").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                
                return completed()
            }
            self.gameArray = []
            for document in QuerySnapshot!.documents {
                let spot = GameToSave(dictionary: document.data())
                spot.documentID = document.documentID
                self.gameArray.append(spot)
            }
            completed()
        }
    }
    
}
