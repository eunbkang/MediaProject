//
//  TVDetailCollectionViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit
import Kingfisher

class TVDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet var stillImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stillImageView.contentMode = .scaleAspectFill
        stillImageView.layer.cornerRadius = 12
        stillImageView.clipsToBounds = true
    }
    
    func configData(row: Episode) {
        titleLabel.text = "\(row.episodeNumber): \(row.name)"
        
        if let stillUrl = URL(string: row.stillUrl) {
            stillImageView.kf.setImage(with: stillUrl)
        }
    }
}
