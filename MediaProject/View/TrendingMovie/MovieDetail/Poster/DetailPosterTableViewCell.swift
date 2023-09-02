//
//  DetailPosterTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Kingfisher

class DetailPosterTableViewCell: UITableViewCell {

    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOpacity = 0.9
        titleLabel.layer.shadowRadius = 4
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleLabel.layer.masksToBounds = false
        titleLabel.clipsToBounds = false
    }

    func configData(row: MovieResult) {
        titleLabel.text = row.title
        
        
        guard let backdropUrl = URL.PathType.image.makeUrl(id: row.backdropPath, season: nil, page: nil),
              let posterUrl = URL.PathType.image.makeUrl(id: row.posterPath, season: nil, page: nil)
        else { return }
        
        backdropImageView.kf.setImage(with: backdropUrl)
        posterImageView.kf.setImage(with: posterUrl)
        
//        if let backdropUrlString = row.backdropImageUrl {
//            guard let backdropUrl = URL(string: backdropUrlString) else { return }
//            backdropImageView.kf.setImage(with: backdropUrl)
//        }
//        if let posterUrlString = row.posterImageUrl {
//            guard let posterUrl = URL(string: posterUrlString) else { return }
//            posterImageView.kf.setImage(with: posterUrl)
//        }
    }
}
