//
//  TrendingTVTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/09/02.
//

import UIKit
import Kingfisher

class TrendingTVTableViewCell: BaseTableViewCell {

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
        view.configShadow(cornerRadius: cornerRadius, opacity: 0.3, radius: 6)
        
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
    
    private let tvLabel: UILabel = {
        let label = UILabel()
        label.text = "TV"
        label.textColor = .white
        label.backgroundColor = .systemPink
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        
        return label
    }()

    private let cornerRadius: CGFloat = 12
    
    // MARK: - BaseTableViewCell
    
    override func configViewComponents() {
        selectionStyle = .none
        
        contentView.addSubview(cardShadowView)
        contentView.addSubview(cardBackView)
        contentView.addSubview(genreLabel)
        
        let subViewList = [posterImageView, tvLabel, releaseDateLabel, titleLabel, originalTitleLabel, rateStackView]
        
        for item in subViewList {
            cardBackView.addSubview(item)
        }
    }
    
    override func configLayoutConstraints() {
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        cardBackView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        
        cardShadowView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(cardBackView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.333333)
            make.top.trailing.bottom.equalToSuperview()
        }
        
        tvLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(52)
            make.top.equalToSuperview().inset(16)
            make.trailing.equalTo(posterImageView.snp.leading).offset(-16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tvLabel)
            make.leading.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(posterImageView.snp.leading).offset(-16)
            make.top.equalTo(tvLabel.snp.bottom).offset(12)
            make.height.equalTo(21)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
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
            make.trailing.equalTo(tvLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Helper
    
    func setDataToView(_ tv: Trending) {
        releaseDateLabel.text = tv.firstAirDate
        titleLabel.text = tv.name
        originalTitleLabel.text = tv.originalName
        genreLabel.text = tv.genres
        
        if let rate = tv.voteAverage {
            rateLabel.text = String(format: "%.1f", rate)
        }
        
        guard let url = URL.PathType.image.makeUrl(id: tv.posterPath, season: nil, page: nil) else { return }
        posterImageView.kf.setImage(with: url)
    }
    
}
