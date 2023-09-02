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
        
        guard let url = URL.PathType.image.makeUrl(id: movie.posterPath, season: nil, page: nil) else { return }
        posterImageView.kf.setImage(with: url)
        
//        if let urlString = movie.posterImageUrl {
//            guard let url = URL(string: urlString) else { return }
//            posterImageView.kf.setImage(with: url)
//        }
    }
}
