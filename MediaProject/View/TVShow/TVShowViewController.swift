//
//  TVShowViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit

class TVShowViewController: UIViewController {
    
    @IBOutlet var tvShowTableView: UITableView!
    
    var tvList: [TVResult] = []
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trendingTableViewCellNib = UINib(nibName: TrendingTableViewCell.identifier, bundle: nil)
        tvShowTableView.register(trendingTableViewCellNib, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        
        tvShowTableView.delegate = self
        tvShowTableView.dataSource = self
        
        configTableView()
        callRequest(page: page)
    }
    
    func callRequest(page: Int) {
        TMDBManager.shared.callTrendingTVRequest(page: page) { resultList in
            self.tvList.append(contentsOf: resultList)
            self.tvShowTableView.reloadData()
        }
    }
}

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
        
        let sb = UIStoryboard(name: "TVDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: TVDetailViewController.identifier) as? TVDetailViewController else { return }
        
        vc.seriesId = tvList[indexPath.row].id
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension TVShowViewController {
    func configTableView() {
        tvShowTableView.rowHeight = 424
        tvShowTableView.separatorStyle = .none
    }
}
