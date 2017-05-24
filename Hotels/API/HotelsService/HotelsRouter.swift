//
//  HotelsRouter.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Alamofire

enum HotelsRouter: URLRequestConvertible {
    
    case getHotels
    case getHotelDetails(id: Int)
    case getHotelReviews(id: Int)
    case getFavoriteHotels
    case addToFavorites(id: Int)
    case removeFromFavorites(id: Int)
    case addHotel(hotel: Hotel)
    case getReviews(id: Int)
    //case incrementCounter
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .addToFavorites, .removeFromFavorites, .addHotel:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        
        switch self {
        case .getHotels, .addHotel:
            return Constants.API.Endpoints.Hotels.getHotels
        case .getHotelDetails(let id):
            return Constants.API.Endpoints.Hotels.getHotels + String(id)
        case .getHotelReviews(let id):
            return Constants.API.Endpoints.Hotels.getHotelReviews + String(id)
        case .getFavoriteHotels:
            return Constants.API.Endpoints.Hotels.getFavorite
        case .addToFavorites, .removeFromFavorites:
            return Constants.API.Endpoints.Hotels.addRemove
        case .getReviews(let id):
            return Constants.API.Endpoints.Hotels.getHotelReviews + String(id)
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .addToFavorites(let id):
            return [Constants.API.Parameters.hotelID : id, Constants.API.Parameters.isFavorite : true]
        case .removeFromFavorites(let id):
            return [Constants.API.Parameters.hotelID : id, Constants.API.Parameters.isFavorite : false]
        case .addHotel(let hotel):
            return [Constants.API.Parameters.name : hotel.name!, Constants.API.Parameters.city : hotel.city!, Constants.API.Parameters.country : hotel.country!, Constants.API.Parameters.description : hotel.description!, Constants.API.Parameters.location : hotel.location!, Constants.API.Parameters.price : hotel.price!, Constants.API.Parameters.stars : hotel.stars!, Constants.API.Parameters.user : 2]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.Endpoints.baseUrl.asURL()
        
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .addToFavorites, .removeFromFavorites, .addHotel:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default: break
        }
        return urlRequest
    }
}
