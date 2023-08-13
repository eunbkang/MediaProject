//
//  TMDBManager.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDBManager {
    
    static let shared = TMDBManager()
    private init() { }
    
    let header: HTTPHeaders = [
        "Authorization": "Bearer \(APIKey.tmbdToken)"
    ]
    
    func callRequest(url: String, completion: @escaping (JSON) -> ()) {
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completion(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
