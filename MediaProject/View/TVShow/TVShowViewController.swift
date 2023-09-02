//
//  TVShowViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit

class TVShowViewController: BaseViewController {
    
    private let tvShowView = TrendingView()
    
    private var tvList: [TVResult] = []
    private var page: Int = 1
    
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
    
    private func callRequest(page: Int) {
        guard let url = URL.PathType.trendingTV.makeUrl(id: nil , season: nil, page: page) else { return }
        
        TMDBManager.shared.callRequest(url: url, model: TVTrending.self) { value in
            guard let value else { return }
            self.tvList.append(contentsOf: value.results)
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
        
        transitView(vc: vc, type: .push)
    }
}
