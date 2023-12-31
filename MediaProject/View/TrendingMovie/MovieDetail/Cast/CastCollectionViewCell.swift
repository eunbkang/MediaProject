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
        castImageView.layer.cornerRadius = 8
        castImageView.clipsToBounds = true
    }

    func configData(cast: Cast) {
        nameLabel.text = cast.name
        roleLabel.text = cast.character

        guard let url = URL.PathType.image.makeUrl(id: cast.profilePath, season: nil, page: nil) else { return }
        castImageView.kf.setImage(with: url)
        
//        if let urlString = cast.profileImageUrl {
//            guard let url = URL(string: urlString) else { return }
//            castImageView.kf.setImage(with: url)
//        }
    }
}
