//
//  MovieDetailViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit
import Alamofire

class MovieDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    let mainView = MovieDetailView()
    
    var movie: MovieResult?
    var castList: [Cast]?
    var videoList: [Video]?
    var similarMovieList: [MovieResult]?
    
    var isShowingMore: Bool = false
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
    }
    
    // MARK: - BaseViewController
    
    override func configViewComponents() {
        super.configViewComponents()
        
        title = "정보"
        
        mainView.movieDetailTableView.delegate = self
        mainView.movieDetailTableView.dataSource = self
    }
    
    func callRequest() {
        guard let movieId = movie?.id else { return }
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBManager.shared.callCreditRequest(movieId: movieId) { resultList in
            self.castList = resultList
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.callMovieVideoRequest(movieId: movieId) { resultList in
            self.videoList = resultList
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.callSimilarMovieRequest(movieId: movieId) { resultList in
            self.similarMovieList = resultList
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.movieDetailTableView.reloadData()
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
            
            cell.videoList = videoList
            
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
