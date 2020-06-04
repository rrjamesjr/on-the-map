//
//  HttpClient.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation

class HttpClient {
    
    static var baseUrl: String {
        return "https://onthemap-api.udacity.com/v1"
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void, skipBytes: Int = 0) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(responseType.self, from: getReponseData(data: data, skipBytes: skipBytes))
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body: RequestType, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Data?, Error?) -> Void, skipBytes: Int = 0) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(error!)
                DispatchQueue.main.async {
                    completion(nil, nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
    
            let newData = getReponseData(data: data, skipBytes: skipBytes)
            do {
                
                let responseObject = try decoder.decode(responseType.self, from: newData)
                
                DispatchQueue.main.async {
                    completion(responseObject, nil, nil)
                }
            } catch {
                print(error)
                    DispatchQueue.main.async {
                        completion(nil, newData, error)
                }
            }
        }
        
        task.resume()
    }
    
    class func getReponseData(data: Data, skipBytes: Int) -> Data {
        let range = skipBytes..<data.count
        return data.subdata(in: range)
    }
}
