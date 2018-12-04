//
//  RandomUIButton.swift
//  Game Partner
//
//  Created by Brennan Nugent on 12/4/18.
//  Copyright © 2018 Brennan Nugent. All rights reserved.
//

import UIKit

class RandomUIButton: UIButton {

    let number = Int.random(in: 57703 ..< 70381)
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameDetailSegue" {
            let destination = segue.destination as! GameDetailsViewController
            destination.gameID = "3030-\(number)"
        }
    }
}
