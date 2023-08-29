//
//  ProfileView.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    lazy var profileTableView: UITableView = {
        let view = UITableView()
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        view.rowHeight = 48
        
        return view
    }()
    
    override func configViewComponents() {
        addSubview(profileTableView)
    }
    
    override func configLayoutConstraints() {
        profileTableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
