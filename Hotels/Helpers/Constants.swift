//
//  Constants.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        
        struct Endpoints {
            static let baseUrl = "http://hotels.api"
            
            struct User {
                static let register = "register/"
                static let login = "api-token-auth/"
            }
            
            struct Hotels {
                static let getHotels = "hotel_api/"
                static let getHotelReviews = "hotel_api/get_hotel_reviews/"
                static let getFavorite = "favorites/"
                static let addRemove = "favorites/add_remove"
            }
            
        }
        
        struct Parameters {
            static let username = "username"
            static let password = "password"
            static let firstname = "first_name"
            static let lastname = "last_name"
            static let email = "email"
            static let hotelID = "hotel_id"
            static let isFavorite = "is_favorite"
            static let name = "name"
            static let city = "city"
            static let country = "country"
            static let image = "image"
            static let stars = "stars"
            static let description = "description"
            static let price = "price"
            static let likes = "likes"
            static let dislikes = "dislikes"
            static let location = "location"
            static let user = "user"
        }
        
        struct Headers {
            static let token = "token"
            static let authorization = "Authorization"
            static let contentType = "Content-Type"
            static let applicationJson = "application/json"
        }
    }
    
    struct Keys {
        
        struct User {
            static let firstname = "first_name"
            static let lastname = "last_name"
            static let email = "email"
            static let username = "username"
            static let password = "password"
            static let token = "token"
        }
        
        struct Hotel {
            static let id = "id"
            static let name = "name"
            static let city = "city"
            static let country = "country"
            static let image = "image"
            static let stars = "stars"
            static let description = "description"
            static let price = "price"
            static let likes = "likes"
            static let dislikes = "dislikes"
            static let location = "location"
        }
        
        struct Review {
            static let id = "id"
            static let message = "message"
            static let createdAt = "createdAt"
            static let positive = "positive"
            static let likes = "likes"
            static let dislikes = "dislikes"
            static let author = "author"
        }
        
    }
    
    struct Keychain {
        static let token = "token"
        
    }
    
    struct Segue {
        static let showHotels = "showHotels"
    }
    
    struct Notifications {
        
    }
}
