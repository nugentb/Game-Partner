//
//  EditConsoleViewController.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/2/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class EditConsoleViewController: UIViewController {

    var consoles: Consoles!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        consoles = Consoles()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        consoles.loadData {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
//    
//    var tempArray = ["Xbox One", "PlayStation 4"]
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearAllButtonPressed(_ sender: UIButton) {
        let db = Firestore.firestore()
        db.collection("consoles").whereField("ownerUserID", isEqualTo: String(describing: Auth.auth().currentUser!.uid))
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        db.collection("consoles").document(document.documentID).delete()
                    }
                }
        }
    }
    
    
}

extension EditConsoleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consoles.consoleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsoleCell", for: indexPath)
        cell.textLabel?.text = consoles.consoleArray[indexPath.row].consoleName
        return cell
    }
    
}
