//
//  TrendingViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Alamofire

class TrendingViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var trendingTableView: UITableView!
    
    lazy var mapButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(tappedMapButton))
        button.tintColor = .black
        
        return button
    }()
    
    var movieList: [MovieResult] = []
    var page = 1
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = mapButton
        
        let trendingTableViewCellNib = UINib(nibName: TrendingTableViewCell.identifier, bundle: nil)
        trendingTableView.register(trendingTableViewCellNib, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        trendingTableView.prefetchDataSource = self
        
        configTableView()
        callRequest(page: page)
    }
    
    // MARK: - Action
    
    @objc func tappedMapButton() {
        let vc = TheaterMapViewController()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    // MARK: - Helper
    
    func callRequest(page: Int) {
        TMDBManager.shared.callTrendingRequest(page: page) { resultList in
            self.movieList.append(contentsOf: resultList)
            self.trendingTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier) as? TrendingTableViewCell else { return UITableViewCell() }
        
        cell.configMovieToView(movie: movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
        
        vc.movie = movieList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension TrendingViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieList.count - 1 == indexPath.row && page < 50 {
                page += 1
                callRequest(page: page)
            }
        }
    }
}

// MARK: - UI

extension TrendingViewController {
    func configTableView() {
        trendingTableView.rowHeight = 424
        trendingTableView.separatorStyle = .none
    }
}
