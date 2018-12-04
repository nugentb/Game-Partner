//
//  MyGamesViewController.swift
//  
//
//  Created by Brennan Nugent on 12/3/18.
//

import UIKit
import Firebase
import FirebaseUI

class MyGamesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var gamesSaved: GamesSaved!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        gamesSaved = GamesSaved()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gamesSaved.loadData {
            self.tableView.reloadData()
        }
    }


    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearAllButtonPressed(_ sender: UIButton) {
        let db = Firestore.firestore()
        db.collection("games").whereField("ownerUserID", isEqualTo: String(describing: Auth.auth().currentUser!.uid))
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        db.collection("games").document(document.documentID).delete()
                    }
                }
        }
    }
}

extension MyGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesSaved.gameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameItemCell", for: indexPath) as! GameCellTableViewCell
        cell.gameTitle.text = gamesSaved.gameArray[indexPath.row].title
        if (gamesSaved.gameArray[indexPath.row].releaseDate == "") {
            cell.dateOfRelease.text = "Not Released"
            cell.dateOfRelease.textColor = UIColor.red
        } else {
            cell.dateOfRelease.text = "Game Released! Go get it now!"
            cell.dateOfRelease.textColor = UIColor.green
        }
        
        return cell
    }
    
    
}
