//
//  NetworkModel.swift
//  DragonBall_Xib
//
//  Created by sergio serrano on 11/7/22.
//

import Foundation

enum NetworkError: Equatable, Error {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}

class NetworkModel {
    
    let session: URLSession
    
    var token: String?
    
    //static let shared = NetworkModel()
    
    //private init() {}
    
    init(urlSession: URLSession = .shared, token: String? = nil) {
        self.session = urlSession
        self.token = token
    }
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
//        let loginString = user + ":" + password
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, .dataFormatting)
            return
        }
                                 
        let base64LoginString = loginData.base64EncodedString()
                                 
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
                                 
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(nil, .other)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let httpResponse =  (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion(nil, .errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let token = String (data: data, encoding: .utf8) else {
                completion(nil, .tokenFormatError)
                return
            }
            
            completion(token, nil)
        }
        
        task.resume()
    }
    
    func getHeroes(name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/all") else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = self.token else {
            completion([], .other)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let name: String
        }
        
        let body = Body(name: name)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], .other)
                return
            }
            
            guard let data = data else {
                completion([], .noData)
                return
            }
            
            guard let httpResponse =  (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion([], .errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], .decoding)
                return
            }
            completion(heroesResponse, nil)
        }
        task.resume()
    }
    
    func getTransformations(id: String = "", completion: @escaping ([Transformation], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/tranformations") else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = self.token else {
            completion([], .other)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let id: String 
        }
        
        let body = Body(id: id)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], .other)
                return
            }
            
            guard let data = data else {
                completion([], .noData)
                return
            }
            
            guard let httpResponse =  (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion([], .errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroesTransformationResponse = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion([], .decoding)
                return
            }
            completion(heroesTransformationResponse, nil)
        }
        task.resume()
    }
}
