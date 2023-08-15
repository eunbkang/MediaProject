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
    
    func callTrendingRequest(page: Int, completion: @escaping ([Result]) -> ()) {
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
}
