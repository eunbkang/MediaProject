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
        
        guard let url = URL.PathType.image.makeUrl(id: row.stillPath, season: nil, page: nil) else { return }
        stillImageView.kf.setImage(with: url)
    }
}
