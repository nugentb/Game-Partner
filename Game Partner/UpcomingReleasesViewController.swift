//
//  UpcomingReleasesViewController.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/4/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class UpcomingReleasesViewController: UIViewController {

    var games = UpcomingGames()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        games.getGames() {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameDetailSegue" {
            let destination = segue.destination as! GameDetailsViewController
            if let selectedIndex = tableView.indexPathForSelectedRow {
                destination.gameID = games.upcomingGameArray[selectedIndex.row].gameID
            }
        }
    }
    
}

extension UpcomingReleasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.upcomingGameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingReleaseCell", for: indexPath) as! GameCellTableViewCell
        cell.gameTitle.text = games.upcomingGameArray[indexPath.row].title
        var textToFormat = games.upcomingGameArray[indexPath.row].relDateString
        let output = "\(textToFormat[5 ..< 7]) \(textToFormat[8 ..< 10]) \(textToFormat[0 ..< 4])"
        
        cell.dateOfRelease.text = output
        
        return cell
    }
    
}
