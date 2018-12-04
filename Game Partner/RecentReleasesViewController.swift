//
//  RecentReleasesViewController.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/2/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class RecentReleasesViewController: UIViewController {

    var games = RecentGames()
    

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        

        
        games.getGames() {
            self.tableView.reloadData()
        }

    }
    
    var testList = ["Test"]
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameDetailSegue" {
            let destination = segue.destination as! GameDetailsViewController
            if let selectedIndex = tableView.indexPathForSelectedRow {
                destination.gameID = games.recentGameArray[selectedIndex.row].gameID
            }
        }
    }

    
}

extension RecentReleasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.recentGameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentReleaseCell", for: indexPath) as! GameCellTableViewCell
        cell.gameTitle.text = games.recentGameArray[indexPath.row].title
        var textToFormat = games.recentGameArray[indexPath.row].relDateString
        let output = "\(textToFormat[5 ..< 7]) \(textToFormat[8 ..< 10]) \(textToFormat[0 ..< 4])"
        
        cell.dateOfRelease.text = output
        
        return cell
    }
    
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}


