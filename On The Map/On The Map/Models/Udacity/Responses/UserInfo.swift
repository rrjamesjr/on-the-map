//
//  LoginResponse.swift
//  On The Map
//
//  Created by Rudy James Jr on 6/3/20.
//  Copyright © 2020 James Consutling LLC. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}
