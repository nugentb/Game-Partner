//
//  GameCellTableViewCell.swift
//  
//
//  Created by Brennan Nugent on 12/3/18.
//

import UIKit

class GameCellTableViewCell: UITableViewCell {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var dateOfRelease: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
