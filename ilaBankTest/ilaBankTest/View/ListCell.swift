//
//  ListCell.swift
//  ilaBankTest
//
//  Created by Rohan Panchal on 16/08/24.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet var listItemImage: UIImageView!
    @IBOutlet var listItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
