//
//  TrendingPeopleTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/09/02.
//

import UIKit
import Kingfisher

class TrendingPeopleTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let cornerRadius: CGFloat = 12
    
    private lazy var cardShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.configShadow(cornerRadius: cornerRadius, opacity: 0.2, radius: 6)
        
        return view
    }()
    
    private lazy var cardBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    private lazy var departmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, departmentLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - BaseTableViewCell
    
    override func configViewComponents() {
        selectionStyle = .none
        
        contentView.addSubview(cardShadowView)
        contentView.addSubview(cardBackView)
        
        let subViewList = [profileImageView, nameStackView]
        
        for item in subViewList {
            cardBackView.addSubview(item)
        }
        
        profileImageView.image = UIImage(systemName: "person.fill")
        nameLabel.text = "Harrison Ford"
        departmentLabel.text = "Actor"
    }
    
    override func configLayoutConstraints() {
        cardBackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        cardShadowView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(cardBackView)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(1.333333)
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(21)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Helper
    
    func setDataToView(_ person: Trending) {
        nameLabel.text = person.name
        departmentLabel.text = person.knownForDepartment?.rawValue
        
        if let urlString = person.profileImageUrl {
            guard let url = URL(string: urlString) else { return }
            profileImageView.kf.setImage(with: url)
        }
    }
}
