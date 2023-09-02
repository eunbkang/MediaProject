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
    
    func callRequest<T: Codable>(url: URL, model: T.Type, completion: @escaping (T) -> ()) {
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
