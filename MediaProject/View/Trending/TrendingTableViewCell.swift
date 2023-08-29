//
//  TrendingTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Kingfisher

class TrendingTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    private lazy var cardShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.configShadow(cornerRadius: cornerRadius)
        
        return view
    }()
    
    private lazy var cardBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    private lazy var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    private let rateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.textColor = .white
        label.backgroundColor = .systemIndigo
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rateTextLabel, rateLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    private let detailViewLabel: UILabel = {
        let label = UILabel()
        label.text = "자세히 보기"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .footnote)
        
        return label
    }()
    
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.preferredSymbolConfiguration = .init(font: .preferredFont(forTextStyle: .callout))
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let cornerRadius: CGFloat = 12
    
    // MARK: - BaseTableViewCell
    
    override func configViewComponents() {
        selectionStyle = .none
        
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(cardShadowView)
        contentView.addSubview(cardBackView)
        
        let subViewList = [posterImageView, rateStackView, titleLabel, originalTitleLabel, dividerView, detailViewLabel, detailImageView]
        
        for item in subViewList {
            cardBackView.addSubview(item)
        }
    }
    
    override func configLayoutConstraints() {
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(8)
        }
        
        cardBackView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(genreLabel)
            make.bottom.equalTo(contentView).inset(16)
        }
        
        detailViewLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
        }
        
        detailImageView.snp.makeConstraints { make in
            make.centerY.equalTo(detailViewLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(detailViewLabel.snp.top).offset(-20)
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(dividerView.snp.top).offset(-24)
            make.height.equalTo(21)
        }
        titleLabel.snp.contentHuggingHorizontalPriority = 252
        
        originalTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(titleLabel)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-24)
        }
        
        rateTextLabel.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(24)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(rateTextLabel)
        }
        
        rateStackView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(posterImageView).inset(16)
        }
        
        cardShadowView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(cardBackView)
        }
    }
    
    // MARK: - Helpers
    
    func configMovieToView(movie: MovieResult) {
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        releaseDateLabel.text = movie.releaseDate
        rateLabel.text = String(format: "%.1f", movie.voteAverage)
        genreLabel.text = movie.genres
        
        if let url = URL(string: movie.backdropImageUrl) {
            posterImageView.kf.setImage(with: url)
        }
    }
    
    func configTVShowToView(tv: TVResult) {
        titleLabel.text = tv.name
        originalTitleLabel.text = tv.originalName
        releaseDateLabel.text = tv.firstAirDate
        rateLabel.text = String(format: "%.1f", tv.voteAverage)
        genreLabel.text = tv.genres
        
        if let url = URL(string: tv.backdropImageUrl) {
            posterImageView.kf.setImage(with: url)
        }
    }
}
