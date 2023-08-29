//
//  MovieDetailView.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import UIKit

class MovieDetailView: BaseView {
    
    lazy var movieDetailTableView: UITableView = {
        let tableView = UITableView()
        
        let posterCellNib = UINib(nibName: DetailPosterTableViewCell.identifier, bundle: nil)
        let overviewCellNib = UINib(nibName: OverViewTableViewCell.identifier, bundle: nil)
        let castCellNib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        let videoCellNib = UINib(nibName: VideoTableViewCell.identifier, bundle: nil)
        let similarCellNib = UINib(nibName: SimilarTableViewCell.identifier, bundle: nil)
        tableView.register(posterCellNib, forCellReuseIdentifier: DetailPosterTableViewCell.identifier)
        tableView.register(overviewCellNib, forCellReuseIdentifier: OverViewTableViewCell.identifier)
        tableView.register(castCellNib, forCellReuseIdentifier: CastTableViewCell.identifier)
        tableView.register(videoCellNib, forCellReuseIdentifier: VideoTableViewCell.identifier)
        tableView.register(similarCellNib, forCellReuseIdentifier: SimilarTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override func configViewComponents() {
        addSubview(movieDetailTableView)
    }
    
    override func configLayoutConstraints() {
        movieDetailTableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
