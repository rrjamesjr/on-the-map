//
//  StudentLocationClient.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation

class StudentLocationClient: HttpClient {
    static var studentLocationUrl: String {
        return "\(super.baseUrl)/StudentLocation"
    }
    
    enum Endpoints {
        case locations
        
        var url: URL {
            switch self {
            case .locations: return URL(string: "\(studentLocationUrl)?limit=100&order=-updatedAt")!
            }
        }
    }
    
    class func getStudentLocations(completion: @escaping ([StudentLocation], Error?) -> Void) {
        _ = super.taskForGETRequest(url: Endpoints.locations.url, responseType: GetStudentLocationResponse.self) { (responseObject, error) in
            if let responseObject = responseObject {
                completion(responseObject.results, nil)
            } else {
                print(error!)
                completion([], error)
            }
        }
    }
    
    class func addStudentLocation(studentLocation: StudentLocation, completion: @escaping (AddStudentLocationResponse?, Error?) -> Void) {
        taskForPOSTRequest(url: URL(string: studentLocationUrl)!, body: studentLocation, responseType: AddStudentLocationResponse.self) { (response, data, error) in
            guard let response = response else {
                completion(nil, error)
                return
            }
            
            completion(response, nil)
        }
    }
}
