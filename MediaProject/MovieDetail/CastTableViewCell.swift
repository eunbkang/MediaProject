//
//  CastTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet var castImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var roleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castImageView.layer.cornerRadius = 8
        castImageView.clipsToBounds = true
    }
    
    func configData(row: Cast) {
        nameLabel.text = row.name
        roleLable.text = row.character
        
        if let imageUrl = URL(string: row.profileImageUrl) {
            castImageView.kf.setImage(with: imageUrl)
        }
    }
}
