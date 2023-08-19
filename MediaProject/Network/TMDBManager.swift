//
//  TMDBManager.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation
import Alamofire

class TMDBManager {
    
    static let shared = TMDBManager()
    private init() { }
    
    let header: HTTPHeaders = [
        "Authorization": "Bearer \(APIKey.tmbdToken)"
    ]
    
    func callTrendingRequest(page: Int, completion: @escaping ([MovieResult]) -> ()) {
        let url = URL.makeEndPointUrl() + "&page=\(page)"
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: MovieTrending.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callTrendingTVRequest(page: Int, completion: @escaping ([TVResult]) -> ()) {
        let url = URL.makeTVTrendingUrl() + "&page=\(page)"
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: TVTrending.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callCreditRequest(movieId: Int, completion: @escaping ([Cast]) -> ()) {
        let url = URL.makeCreditUrl(movieId: movieId)
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: MovieCredit.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value.cast)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callTVDetailRequest(seriesId: Int, completion: @escaping (TVDetail) -> ()) {
        let url = URL.makeTVDetailUrl(seriesId: seriesId)
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: TVDetail.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callTVSeasonRequest(seriesId: Int, seasonNo: Int, completion: @escaping (TVSeason) -> ()) {
        let url = URL.makeTVSeasonUrl(seriesId: seriesId, seasonNo: seasonNo)
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: TVSeason.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callMovieVideoRequest(movieId: Int, completion: @escaping ([Video]) -> ()) {
        let url = URL.makeMovieVideoUrl(movieId: movieId)
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: MovieVideos.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callSimilarMovieRequest(movieId: Int, completion: @escaping ([MovieResult]) -> ()) {
        let url = URL.makeSimilarMovieUrl(movieId: movieId)
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: SimilarMovies.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
