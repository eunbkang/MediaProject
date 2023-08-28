//
//  TrendingView.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/28.
//

import UIKit

class TrendingView: BaseView {
    
    lazy var trendingTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        view.rowHeight = 424
        
        return view
    }()
    
    override func configViewComponents() {
        addSubview(trendingTableView)
    }
    
    override func configLayoutConstraints() {
        trendingTableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
