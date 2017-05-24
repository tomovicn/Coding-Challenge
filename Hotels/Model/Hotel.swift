//
//  Hotel.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import ObjectMapper

class Hotel: Mappable {
    var id: Int?
    var name: String?
    var city: String?
    var country: String?
    var imageUrl: String?
    var stars: Int?
    var description: String?
    var price: Double?
    var likes: Int?
    var dislikes: Int?
    var location: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id           <- map[Constants.Keys.Hotel.id]
        name         <- map[Constants.Keys.Hotel.name]
        city         <- map[Constants.Keys.Hotel.city]
        country       <- map[Constants.Keys.Hotel.country]
        imageUrl     <- map[Constants.Keys.Hotel.image]
        stars        <- map[Constants.Keys.Hotel.stars]
        description  <- map[Constants.Keys.Hotel.description]
        price        <- map[Constants.Keys.Hotel.price]
        likes        <- map[Constants.Keys.Hotel.likes]
        dislikes     <- map[Constants.Keys.Hotel.dislikes]
        location     <- map[Constants.Keys.Hotel.location]
    }
    
}

extension Hotel: Equatable {
//    func isEqual(_ object: Any?) -> Bool {
//        if object is Hotel {
//            if let hotel = object as? Hotel {
//                return hotel.id == self.id
//            }
//        }
//        return false
//    }
    
    static func ==(lhs: Hotel, rhs: Hotel) -> Bool {
        return lhs.id == rhs.id
        
    }
}
