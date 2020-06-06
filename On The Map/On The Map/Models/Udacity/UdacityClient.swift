//
//  UdacityClient.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation

class UdacityClient: HttpClient {
    static var udacityUrl: URL {
        return URL(string: "\(super.baseUrl)/session")!
    }
    
    struct UdacityErrorResponse: Codable {
        let status: Int
        let error: String
    }
    
    static var userInfo: UserInfo?
    
    class func login(username: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        let udacity = ["username" : username, "password" : password]
        let body = LoginRequest(udacity: udacity)
        taskForPOSTRequest(url: udacityUrl, body: body, responseType: UserInfo.self, skipBytes: 5) { (responseObject, data, error) in
            if let responseObject = responseObject {
                userInfo = responseObject
                
                completion(true, nil)
            } else {
                if let data = data {
                    do {
                        let responseObject = try JSONDecoder().decode(UdacityErrorResponse.self, from: data)
                        completion(false, OnTheMapError(localizedDescription: responseObject.error))
                    }
                    catch {
                        completion(false, error)
                    }
                }
            }
        }
    }
    
    class func logout() {
        var request = URLRequest(url: udacityUrl)
        request.httpMethod = "DELETE"
        request.setValue(userInfo?.session.id, forHTTPHeaderField: "X-XSRF-TOKEN")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          let range = 5..<data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
