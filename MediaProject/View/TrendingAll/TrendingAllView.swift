//
//  TrendingAllView.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/09/02.
//

import UIKit

class TrendingAllView: BaseView {
    
    lazy var trendingAllTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.register(TrendingMovieTableViewCell.self, forCellReuseIdentifier: TrendingMovieTableViewCell.identifier)
        tableView.register(TrendingTVTableViewCell.self, forCellReuseIdentifier: TrendingTVTableViewCell.identifier)
        tableView.register(TrendingPeopleTableViewCell.self, forCellReuseIdentifier: TrendingPeopleTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override func configViewComponents() {
        addSubview(trendingAllTableView)
    }
    
    override func configLayoutConstraints() {
        trendingAllTableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
