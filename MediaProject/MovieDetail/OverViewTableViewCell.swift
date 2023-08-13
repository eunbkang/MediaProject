//
//  OverViewTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {

    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overViewLabel.numberOfLines = 2
    }
    
    func configData(row: Movie) {
        overViewLabel.text = row.overview
    }
}
