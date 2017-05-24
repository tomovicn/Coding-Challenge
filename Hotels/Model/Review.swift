//
//  Review.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import ObjectMapper

class Review: Mappable {
    var id: Int?
    var message: String?
    var createdAt: String?
    var positive: Bool?
    var likes: Int?
    var dislikes: Int?
    var author: Author?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map[Constants.Keys.Review.id]
        message     <- map[Constants.Keys.Review.message]
        createdAt   <- map[Constants.Keys.Review.createdAt]
        positive    <- map[Constants.Keys.Review.positive]
        likes       <- map[Constants.Keys.Review.likes]
        dislikes    <- map[Constants.Keys.Review.dislikes]
        author      <- map[Constants.Keys.Review.author]
    }
    
}

class Author: Mappable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id        <- map[Constants.Keys.Hotel.id]
        firstName <- map[Constants.Keys.User.firstname]
        lastName  <- map[Constants.Keys.User.lastname]
    }
}
