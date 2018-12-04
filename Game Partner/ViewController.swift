//
//  ViewController.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/1/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController {
    
    var allGames = AllGames()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var authUI: FUIAuth!
    var consoles: Consoles!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        consoles = Consoles()
        
        allGames.getGames() {
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        consoles.loadData {
            self.collectionView.reloadData()
        }
    }
    
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()
            ]
        if authUI.auth?.currentUser == nil {
            self.authUI.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        }
        

    }
    
    @IBAction func surpriseMeButtonPressed(_ sender: UIButton) {
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let number = allGames.allGameArray.randomElement()!.gameID
        if segue.identifier == "GameDetailSegue" {
            let destination = segue.destination as! GameDetailsViewController
            destination.gameID = number
        }
    }

    
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        
        do {
            try authUI!.signOut()
            print("SUCCESSFULLY SIGNED OUT")
            signIn()
        } catch {
            print("ERROR COULD NOT SIGN OUT")
        }
        
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return Number of cells
        return consoles.consoleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameRepCollectionViewCell
        gameCell.gameImage.image = UIImage(named: consoles.consoleArray[indexPath.row].consoleName)
        return gameCell
    }
    
    
}

extension ViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        if let user = user {
        print("WE SIGNED IN WITH USER \(user.email ?? "Unknown email")")
        }
    }
}
