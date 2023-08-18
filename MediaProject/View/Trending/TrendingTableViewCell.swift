//
//  TrendingTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Kingfisher

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet var cardShadowView: UIView!
    @IBOutlet var cardBackView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    let cornerRadius: CGFloat = 12
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        cardShadowView.configShadow(cornerRadius: cornerRadius)
        cardBackView.layer.cornerRadius = cornerRadius
        cardBackView.clipsToBounds = true
    }
    
    func configMovieToView(movie: MovieResult) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        rateLabel.text = String(format: "%.1f", movie.voteAverage)
        genreLabel.text = movie.genres
        
        if let url = URL(string: movie.backdropImageUrl) {
            posterImageView.kf.setImage(with: url)
        }
    }
    
    func configTVShowToView(tv: TVResult) {
        titleLabel.text = tv.name
        releaseDateLabel.text = tv.firstAirDate
        rateLabel.text = String(format: "%.1f", tv.voteAverage)
        genreLabel.text = tv.genres
        
        if let url = URL(string: tv.backdropImageUrl) {
            posterImageView.kf.setImage(with: url)
        }
    }
}
