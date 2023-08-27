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
        
        if let backdropUrl = URL(string: row.backdropImageUrl) {
            backdropImageView.kf.setImage(with: backdropUrl)
        }
        if let posterUrl = URL(string: row.posterImageUrl) {
            posterImageView.kf.setImage(with: posterUrl)
        }
    }
}
