//
//  GameToSave.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/3/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class GameToSave {
    var title = ""
    var releaseDate = ""
    var gameID = ""
    var ownerUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["title": title, "gameID":gameID, "releaseDate": releaseDate, "ownerUserID": ownerUserID, "documentID": documentID]
    }
    
    init(title: String, gameID: String, releaseDate: String, ownerUserID: String, documentID: String) {
        self.title = title
        self.gameID = gameID
        self.releaseDate = releaseDate
        self.ownerUserID = ownerUserID
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let title = dictionary["title"] as! String? ?? ""
        let gameID = dictionary["gameID"] as! String? ?? ""
        let releaseDate = dictionary["releaseDate"] as! String? ?? ""
        let ownerUserID = dictionary["ownerUserID"] as! String? ?? ""
        self.init(title: title, gameID: gameID, releaseDate: releaseDate, ownerUserID: ownerUserID, documentID: "")
    }
    
    convenience init() {
        let ownerUserID = Auth.auth().currentUser?.email ?? "Unknown User"
        self.init(title: "", gameID: "", releaseDate: "", ownerUserID: "", documentID: "")
    }
    
    
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the userID
        guard let ownerUserID = (Auth.auth().currentUser?.uid) else {
            return completed(false)
        }
        self.ownerUserID = ownerUserID
        // Create the Dictionary representing the data we want to save
        let dataToSave = self.dictionary
        // if we HAVE saved a record, we will have a documentID
        if self.documentID != "" {
            let ref = db.collection("games").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    completed(false)
                } else {
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil
            ref = db.collection("games").addDocument(data: dataToSave) { error in
                if let error = error {
                    completed(false)
                } else {
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
        }
    }
}
