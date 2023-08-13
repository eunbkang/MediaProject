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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let trencingTableViewCellNib = UINib(nibName: TrendingTableViewCell.identifier, bundle: nil)
        trendingTableView.register(trencingTableViewCellNib, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        
        configTableView()
        callTrendingRequest()
    }
    
    func callTrendingRequest() {
        TMDBManager.shared.callRequest(type: .trending) { json in
            self.makeMovieListFromJson(json: json)
        }
    }

        func makeMovieListFromJson(json: JSON) {
        let results = json["results"].arrayValue
        
        for item in results {
            let title = item["title"].stringValue
            let releaseDate = item["release_date"].stringValue
            let genres = item["genre_ids"].arrayValue
            let poster = item["poster_path"].stringValue
            let rate = item["vote_average"].doubleValue
            
            var genreIds: [Int] = []
            
            for id in genres {
                genreIds.append(id.intValue)
            }
            
            let movie = Movie(title: title, posterImagePath: poster, releaseDate: releaseDate, genreIds: genreIds, rate: rate)
            
            movieList.append(movie)
        }
        self.trendingTableView.reloadData()
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier) as? TrendingTableViewCell else { return UITableViewCell() }
        
        cell.configMovieToView(movie: movieList[indexPath.row])
        
        return cell
    }
}

extension TrendingViewController {
    func configTableView() {
        trendingTableView.rowHeight = 424
        trendingTableView.separatorStyle = .none
    }
}
