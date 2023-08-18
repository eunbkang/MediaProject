//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {

    @IBOutlet var movieDetailTableView: UITableView!
    
    var movie: MovieResult?
    var castList: [Cast]?
    var similarMovieList: [MovieResult]?
    
    var isShowingMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configTableView()
        
        callRequest()
    }
    
    func callRequest() {
        guard let movieId = movie?.id else { return }
        
        TMDBManager.shared.callCreditRequest(movieId: movieId) { resultList in
            self.castList = resultList
            self.movieDetailTableView.reloadSections([MovieDetailSection.cast.rawValue], with: .automatic)
        }
        
        TMDBManager.shared.callSimilarMovieRequest(movieId: movieId) { resultList in
            self.similarMovieList = resultList
            self.movieDetailTableView.reloadSections([MovieDetailSection.similar.rawValue], with: .automatic)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieDetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MovieDetailSection.poster.rawValue: return 1
        case MovieDetailSection.overview.rawValue: return 1
        case MovieDetailSection.cast.rawValue: return 1
        case MovieDetailSection.video.rawValue: return 1
        case MovieDetailSection.similar.rawValue: return 1
        default: return 0
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
            
            cell.isShowingMore = isShowingMore
            cell.configMoreButton()
            cell.configData(row: movie)
            
            return cell
            
        case MovieDetailSection.cast.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.castList = castList
            
            return cell
            
        case MovieDetailSection.video.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
            
            return cell
            
        case MovieDetailSection.similar.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarTableViewCell.identifier) as? SimilarTableViewCell else { return UITableViewCell() }
            
            cell.movieList = similarMovieList
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case MovieDetailSection.overview.rawValue:
            return MovieDetailSection.overview.header
            
        case MovieDetailSection.cast.rawValue:
            return MovieDetailSection.cast.header
            
        case MovieDetailSection.video.rawValue:
            return MovieDetailSection.video.header
            
        case MovieDetailSection.similar.rawValue:
            return MovieDetailSection.similar.header
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = MovieDetailSection.overview.rawValue
        if indexPath == [section, 0] {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier) as? OverViewTableViewCell else { return }
            
            isShowingMore.toggle()
            cell.configMoreButton()

            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UI

extension MovieDetailViewController {
    func configUI() {
        title = "출연/제작"
    }
    
    func configTableView() {
        let posterCellNib = UINib(nibName: DetailPosterTableViewCell.identifier, bundle: nil)
        let overviewCellNib = UINib(nibName: OverViewTableViewCell.identifier, bundle: nil)
        let castCellNib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        let videoCellNib = UINib(nibName: VideoTableViewCell.identifier, bundle: nil)
        let similarCellNib = UINib(nibName: SimilarTableViewCell.identifier, bundle: nil)
        movieDetailTableView.register(posterCellNib, forCellReuseIdentifier: DetailPosterTableViewCell.identifier)
        movieDetailTableView.register(overviewCellNib, forCellReuseIdentifier: OverViewTableViewCell.identifier)
        movieDetailTableView.register(castCellNib, forCellReuseIdentifier: CastTableViewCell.identifier)
        movieDetailTableView.register(videoCellNib, forCellReuseIdentifier: VideoTableViewCell.identifier)
        movieDetailTableView.register(similarCellNib, forCellReuseIdentifier: SimilarTableViewCell.identifier)
        
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        movieDetailTableView.rowHeight = UITableView.automaticDimension
        movieDetailTableView.estimatedRowHeight = 100
    }
}
