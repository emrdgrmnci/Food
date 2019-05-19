////
////  Webservice.swift
////  Food
////
////  Created by Ali Emre Değirmenci on 13.05.2019.
////  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
////
//
//import Foundation
//
//enum APIError: Error {
//    case responseProblem
//    case decodingProblem
//    case encodingProblem
//}
//
//class Webservice {
//    
//    func getFoods(url: URL, completion: @escaping ([Article]?) -> ()) {
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil)
//            } else if let data = data {
//                
//                 let menuList = try? JSONDecoder().decode(ArticleList.self, from: data)
//                
//                if let menuList = menuList {
//                    completion(menuList.articles)
//                }
//                
//                print(menuList?.articles)
//            }
//        }
//        .resume()
//        
//    }
//    
//    
//    //MARK: Http POST Request!
//    struct APIRequest {
//        let resourceURL: URL
//        
//        init(endpoint: String) {
//            let resourceString = "http://localhost:8080/api/\(endpoint)"
//            guard let resourceURL = URL(string: resourceString) else {fatalError()}
//            
//            self.resourceURL = resourceURL
//        }
//        
//        func save(_ messageToSave: Food, completion: @escaping(Result<Food, APIError>) -> Void) {
//            
//            do {
//                
//                var urlRequest  = URLRequest(url: resourceURL)
//                urlRequest.httpMethod = "POST"
//                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//                urlRequest.httpBody = try JSONEncoder().encode(messageToSave)
//                
//                let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
//                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//                        let jsonData = data else {
//                            completion(.failure(.responseProblem))
//                            return
//                    }
//                    
//                    do {
//                        let foodData = try JSONDecoder().decode(Food.self, from: jsonData)
//                        completion(.success(foodData))
//                    } catch {
//                        completion(.failure(.decodingProblem))
//                    }
//                    
//                }
//                dataTask.resume()
//            }catch {
//                completion(.failure(.encodingProblem))
//            }
//        }
//    }
//    
//    
//    
//}
