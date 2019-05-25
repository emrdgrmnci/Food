//
//  APIRequest.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 25.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL: URL
    
    init (endpoint: String) {
        let resourceString = "http://mehmetguner.pryazilim.com/api/userservice/createtoken/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func isMatched(_ guid: ResultObj, completion: @escaping(Result<ResultObj, APIError>) -> Void) {
        do {
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(guid)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let guidData = try JSONDecoder().decode(ResultObj.self, from: jsonData)
                    completion(.success(guidData))
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
}
}
