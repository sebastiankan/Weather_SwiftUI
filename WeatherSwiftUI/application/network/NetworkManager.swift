//
//  NetworkManager.swift
//  WeatherSwiftUI
//
//  Created by Saba Kananian on 5/31/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager {
    
    static func callAPI(urlString: String, headers: [String: String] = [:], params: Parameters = [:], completed: @escaping (Result<JSON, APIError>)-> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        /// Make header
        var finalHeaders = ["Content-Type": "application/json"]
        finalHeaders.merge(dict: headers)
        
        AF.request(url, method: .get, parameters: params, headers: HTTPHeaders(finalHeaders)).response { response in

            switch response.result {
            case .success(let data):
                
                guard let data = data, let json = try? JSON(data: data) else {
                    completed(.failure(.invalidData))
                    return
                }
                
                completed(.success(json))
                print(json)
                
                break

            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
}
