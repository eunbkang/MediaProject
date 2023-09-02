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
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - BaseViewController
    
    override func configViewComponents() {
        title = "Trending"
        
        mainView.trendingAllTableView.delegate = self
        mainView.trendingAllTableView.dataSource = self
        
        mainView.trendingAllTableView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TrendingAllViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingMovieTableViewCell.identifier) as? TrendingMovieTableViewCell else {
                return UITableViewCell()
            }
            
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTVTableViewCell.identifier) as? TrendingTVTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingPeopleTableViewCell.identifier) as? TrendingPeopleTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
