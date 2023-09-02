//
//  TrendingViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Alamofire

class TrendingViewController: BaseViewController {

    // MARK: - Properties
    
    private let trendingView = TrendingView()
    
    private lazy var mapButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(tappedMapButton))
        button.tintColor = .black
        
        return button
    }()
    
    private var movieList: [MovieResult] = []
    private var page = 1
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = trendingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(page: page)
    }
    
    // MARK: - BaseViewController
    
    override func configViewComponents() {
        super.configViewComponents()
        
        title = "Movie"
        navigationItem.rightBarButtonItem = mapButton
        
        trendingView.trendingTableView.delegate = self
        trendingView.trendingTableView.dataSource = self
        trendingView.trendingTableView.prefetchDataSource = self
        
        trendingView.trendingTableView.separatorStyle = .none
    }
    
    // MARK: - Action
    
    @objc private func tappedMapButton() {
        let vc = TheaterMapViewController()
        vc.modalPresentationStyle = .fullScreen
        
        transitView(vc: vc, type: .present)
    }
    
    // MARK: - Helper
    
    private func callRequest(page: Int) {
        guard let url = URL.PathType.trendingMovie.makeUrl(id: nil, season: nil, page: page) else { return }
        
        TMDBManager.shared.callRequest(url: url, model: MovieTrending.self) { value in
            self.movieList.append(contentsOf: value.results)
            self.trendingView.trendingTableView.reloadData()
        }
        
//        TMDBManager.shared.callTrendingMovieRequest(page: page) { resultList in
//            self.movieList.append(contentsOf: resultList)
//            self.trendingView.trendingTableView.reloadData()
//        }
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
        let vc = MovieDetailViewController()
        vc.movie = movieList[indexPath.row]
        
        transitView(vc: vc, type: .push)
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
