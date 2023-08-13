//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import SwiftyJSON

class MovieDetailViewController: UIViewController {

    @IBOutlet var movieDetailTableView: UITableView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let posterCellNib = UINib(nibName: DetailPosterTableViewCell.identifier, bundle: nil)
        let overviewCellNib = UINib(nibName: OverViewTableViewCell.identifier, bundle: nil)
        let castCellNib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        movieDetailTableView.register(posterCellNib, forCellReuseIdentifier: DetailPosterTableViewCell.identifier)
        movieDetailTableView.register(overviewCellNib, forCellReuseIdentifier: OverViewTableViewCell.identifier)
        movieDetailTableView.register(castCellNib, forCellReuseIdentifier: CastTableViewCell.identifier)
        
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        movieDetailTableView.rowHeight = UITableView.automaticDimension
        movieDetailTableView.estimatedRowHeight = 100
        
        configUI()
        callCreditRequest()
    }
    
    func callCreditRequest() {
        guard let movieId = movie?.id else {
            print("no movieId")
            return
        }
        
        TMDBManager.shared.callRequest(url: URL.makeCreditUrl(movieId: movieId)) { json in
            self.makeCastFromJson(json: json)
        }
    }
    
    func makeCastFromJson(json: JSON) {
        let results = json["results"].arrayValue
        
        var castList: [Cast] = []
        
        for item in results {
            let name = item["name"].stringValue
            let image = item["profile_path"].stringValue
            let character = item["character"].stringValue
            
            let cast = Cast(name: name, profileImage: image, character: character)
            
            castList.append(cast)
        }
        movie?.cast = castList
        
        self.movieDetailTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MovieDetailSection.poster.rawValue:
            return 1
            
        case MovieDetailSection.overview.rawValue:
            return 1
            
        case MovieDetailSection.cast.rawValue:
            guard let cast = movie?.cast else { return 0 }
            return cast.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie else { return UITableViewCell() }
        
        switch indexPath.section {
        case MovieDetailSection.poster.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPosterTableViewCell.identifier) as? DetailPosterTableViewCell else { return UITableViewCell() }
            
            cell.configData(row: movie)
            
            return cell
            
        case MovieDetailSection.overview.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier) as? OverViewTableViewCell else { return UITableViewCell() }
            
            cell.configData(row: movie)
            
            return cell
            
        case MovieDetailSection.cast.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            guard let cast = movie.cast else { return UITableViewCell() }
            
            cell.configData(row: cast[indexPath.row])
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == MovieDetailSection.overview.rawValue {
            return MovieDetailSection.overview.header
        } else if section == MovieDetailSection.cast.rawValue {
            return MovieDetailSection.cast.header
        } else {
            return nil
        }
    }
    
}

// MARK: - UI

extension MovieDetailViewController {
    func configUI() {
        title = "출연/제작"
    }
}
