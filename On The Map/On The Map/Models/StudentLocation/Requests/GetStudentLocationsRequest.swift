//
//  GetStudentLocationsRequest.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation

struct GetStudentLocationsRequest {
    let limit: Int = 50
    let skip:Int = 0
    let order: [String]
}
