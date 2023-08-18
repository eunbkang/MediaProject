//
//  CastCollectionViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/18.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet var castImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var roleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.cornerRadius = 12
        castImageView.clipsToBounds = true
    }

    func configData(cast: Cast) {
        nameLabel.text = cast.name
        roleLabel.text = cast.character

        if let imageUrl = URL(string: cast.profileImageUrl) {
            castImageView.kf.setImage(with: imageUrl)
        }
    }
}
