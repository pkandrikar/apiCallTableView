//
//  UserTableViewCell.swift
//  Assignment
//
//  Created by Sahil Saharkar on 3/1/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label_name:UILabel!
    @IBOutlet weak var label_email:UILabel!
    @IBOutlet weak var avatar:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
