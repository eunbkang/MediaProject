//
//  TrendingAllViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/09/02.
//

import UIKit

class TrendingAllViewController: BaseViewController {

    // MARK: - Properties
    
    private let mainView = TrendingAllView()
    
    private var trendingList: [Trending] = []
    private var page = 1
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest(page: page)
    }
    
    // MARK: - BaseViewController
    
    override func configViewComponents() {
        title = "Trending"
        
        mainView.trendingAllTableView.delegate = self
        mainView.trendingAllTableView.dataSource = self
        mainView.trendingAllTableView.prefetchDataSource = self
        
        mainView.trendingAllTableView.separatorStyle = .none
    }
    
    // MARK: - Helper
    
    private func callRequest(page: Int) {
        guard let url = URL.PathType.trendingAll.makeUrl(id: nil, season: nil, page: page) else { return }
        
        TMDBManager.shared.callRequest(url: url, model: TrendingAll.self) { value in
            self.trendingList.append(contentsOf: value.results)
            self.mainView.trendingAllTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TrendingAllViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trending = trendingList[indexPath.row]
        
        switch trending.mediaType {
        case .movie:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingMovieTableViewCell.identifier) as? TrendingMovieTableViewCell else {
                return UITableViewCell()
            }
            cell.setDataToView(trending)
            
            return cell
            
        case .tv:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTVTableViewCell.identifier) as? TrendingTVTableViewCell else {
                return UITableViewCell()
            }
            cell.setDataToView(trending)
            
            return cell
            
        case .person:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingPeopleTableViewCell.identifier) as? TrendingPeopleTableViewCell else {
                return UITableViewCell()
            }
            cell.setDataToView(trending)
            
            return cell
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension TrendingAllViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if trendingList.count - 1 == indexPath.row && page < 500 {
                page += 1
                callRequest(page: page)
            }
        }
    }
}
