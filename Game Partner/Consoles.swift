//
//  Consoles.swift
//  
//
//  Created by Brennan Nugent on 12/2/18.
//

import Foundation
import Firebase
import FirebaseFirestore

class Consoles {
    var consoleArray = [Console]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("consoles").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                
                return completed()
            }
            self.consoleArray = []
            for document in QuerySnapshot!.documents {
                let spot = Console(dictionary: document.data())
                spot.documentID = document.documentID
                self.consoleArray.append(spot)
            }
            completed()
        }
    }
    
}
