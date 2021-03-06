//
//  StudentLocation.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    var objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    var createdAt: String
    var updatedAt: String
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
