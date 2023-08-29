//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {

    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    let itemContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        
        return label
    }()
    
    override func configViewComponents() {
        selectionStyle = .none
        
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemContentLabel)
    }
    
    override func configLayoutConstraints() {
        itemNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        itemContentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(120)
            make.centerY.equalToSuperview()
        }
    }
}
