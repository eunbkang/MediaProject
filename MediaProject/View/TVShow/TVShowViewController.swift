//
//  TVShowViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit

class TVShowViewController: BaseViewController {
    
    let tvShowView = TrendingView()
    
    var tvList: [TVResult] = []
    var page: Int = 1
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = tvShowView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(page: page)
    }
    
    // MARK: - BaseViewController
    
    override func configViewComponents() {
        super.configViewComponents()

        title = "TV Show"

        tvShowView.trendingTableView.delegate = self
        tvShowView.trendingTableView.dataSource = self
        
        tvShowView.trendingTableView.separatorStyle = .none
    }
    
    // MARK: - Helper
    
    func callRequest(page: Int) {
        TMDBManager.shared.callTrendingTVRequest(page: page) { resultList in
            self.tvList.append(contentsOf: resultList)
            self.tvShowView.trendingTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TVShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier) as? TrendingTableViewCell else { return UITableViewCell() }
        
        cell.configTVShowToView(tv: tvList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TVDetailViewController()
        vc.seriesId = tvList[indexPath.row].id
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
