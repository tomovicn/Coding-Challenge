//
//  User.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var username: String?
    var password: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        firstName <- map[Constants.Keys.User.firstname]
        lastName  <- map[Constants.Keys.User.lastname]
        email     <- map[Constants.Keys.User.email]
        username  <- map[Constants.Keys.User.username]
        password  <- map[Constants.Keys.User.password]
    }
    
}
