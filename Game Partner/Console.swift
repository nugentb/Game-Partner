//
//  Console.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/2/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class Console {
    var consoleName: String
    var ownerUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["consoleName": consoleName, "ownerUserID": ownerUserID, "documentID": documentID]
    }
    
    init(consoleName: String, ownerUserID: String, documentID: String) {
        self.consoleName = consoleName
        self.ownerUserID = ownerUserID
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]) {
        let consoleName = dictionary["consoleName"] as! String? ?? ""
        let ownerUserID = dictionary["ownerUserID"] as! String? ?? ""
        self.init(consoleName: consoleName, ownerUserID: ownerUserID, documentID: "")
    }
    
    convenience init() {
        let ownerUserID = Auth.auth().currentUser?.email ?? "Unknown User"
        self.init(consoleName: "", ownerUserID: "", documentID: "")
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
            let ref = db.collection("consoles").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    completed(false)
                } else {
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil
            ref = db.collection("consoles").addDocument(data: dataToSave) { error in
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
