//
//  SimilarCollectionViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/18.
//

import UIKit
import Kingfisher

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }

    func configData(movie: MovieResult) {
        
        titleLabel.text = movie.title
        
        if let imageUrl = URL(string: movie.posterImageUrl) {
            posterImageView.kf.setImage(with: imageUrl)
        }
    }
}
