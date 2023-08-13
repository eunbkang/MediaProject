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
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }

    func configData(row: Movie) {
        titleLabel.text = row.title
        
        if let backdropUrl = URL(string: row.backdropImageUrl) {
            backdropImageView.kf.setImage(with: backdropUrl)
        }
        if let posterUrl = URL(string: row.posterImageUrl) {
            posterImageView.kf.setImage(with: posterUrl)
        }
    }
}
