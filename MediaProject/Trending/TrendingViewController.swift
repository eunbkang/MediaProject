//
//  TrendingViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import SwiftyJSON

class TrendingViewController: UIViewController {

    @IBOutlet var trendingTableView: UITableView!
    
    var movieList: [Movie] = []
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "  "
        
        let trencingTableViewCellNib = UINib(nibName: TrendingTableViewCell.identifier, bundle: nil)
        trendingTableView.register(trencingTableViewCellNib, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        trendingTableView.prefetchDataSource = self
        
        configTableView()
        callTrendingRequest(page: page)
    }
    
    func callTrendingRequest(page: Int) {
        let url = URL.makeEndPointUrl() + "&page=\(page)"
        
        TMDBManager.shared.callRequest(url: url) { json in
            self.makeMovieListFromJson(json: json)
        }
    }

    func makeMovieListFromJson(json: JSON) {
        let results = json["results"].arrayValue
        
        for item in results {
            let id = item["id"].intValue
            let title = item["title"].stringValue
            let releaseDate = item["release_date"].stringValue
            let overview = item["overview"].stringValue
            let genres = item["genre_ids"].arrayValue
            let poster = item["poster_path"].stringValue
            let backdrop = item["backdrop_path"].stringValue
            let rate = item["vote_average"].doubleValue
            
            var genreIds: [Int] = []
            
            for id in genres {
                genreIds.append(id.intValue)
            }
            
            let movie = Movie(id: id, title: title, posterImagePath: poster, backdropImagePath: backdrop, releaseDate: releaseDate, overview: overview, genreIds: genreIds, rate: rate)
            
            movieList.append(movie)
        }
        self.trendingTableView.reloadData()
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
            if movieList.count - 1 == indexPath.row && page < 1000 {
                page += 1
                callTrendingRequest(page: page)
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
