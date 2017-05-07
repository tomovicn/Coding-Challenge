//
//  HotelsService.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HotelsService {
    let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getHotels(succes: @escaping (_ hotels: [Hotel]) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(HotelsRouter.getHotels).validate().responseArray { (response: DataResponse<[Hotel]>) in
            switch response.result {
            case .success(let hotels):
                succes(hotels)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func getHotelDetails(id: Int, succes: @escaping (_ hotel: Hotel) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(HotelsRouter.getHotelDetails(id: id)).validate().responseObject { (response: DataResponse<Hotel>) in
            switch response.result {
            case .success(let hotel):
                succes(hotel)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func getHotelReviews(id: Int, succes: @escaping (_ reviews: [Review]) -> Void, failure : @escaping ((String) -> Void)) { //http://54.77.217.126:8080/hotel_api/get_hotel_reviews/
        
        let review1 = Review()
        review1.message = "“Massive room and extremely comfortable. Location perfect, right beside the old town and all the nightlife. Free parking just a minute walk away.”"
        review1.likes = 3
        review1.dislikes = 0
        
        let review2 = Review()
        review2.message = "“The place is situated ultra central, it's very nice to take a walk in the evening, eat something at the nearby restaurants or do some shopping. Staff is very helpful.”"
        review2.likes = 0
        review2.dislikes = 0
        
        let review3 = Review()
        review3.message = "“Perfect location, good breakfast, very helpful staff. We were upgraded to a huge room”"
        review3.likes = 0
        review3.dislikes = 0
        
        var reviews = [review1, review2]
        if arc4random_uniform(2) == 0 {
            reviews.append(review3)
        }
        succes(reviews)
        
//        apiManager.request(HotelsRouter.getHotelReviews(id: id)).validate().responseArray { (response: DataResponse<[Review]>) in
//            switch response.result {
//            case .success(let reviews):
//                succes(reviews)
//            case .failure(let error):
//                failure(error.localizedDescription)
//            }
//        }
    }
    
    func getFavorites(succes: @escaping (_ hotels: [Hotel]) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(HotelsRouter.getFavoriteHotels).validate().responseArray { (response: DataResponse<[Hotel]>) in
            switch response.result {
            case .success(let hotels):
                succes(hotels)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func addHotel(hotel: Hotel, succes: @escaping (_ hotel: Hotel) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(HotelsRouter.addHotel(hotel: hotel)).validate().responseObject { (response: DataResponse<Hotel>) in
            switch response.result {
            case .success(let hotel):
                succes(hotel)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func addToFavorites(id: Int, succes: @escaping (_ message: String) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(HotelsRouter.addToFavorites(id: id)).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? NSDictionary {
                    if let message = JSON["Message"] as? String {
                        succes(message)
                    }
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func removeFromFavorites(id: Int, succes: @escaping (_ message: String) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(HotelsRouter.removeFromFavorites(id: id)).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? NSDictionary {
                    if let message = JSON["Message"] as? String {
                        succes(message)
                    }
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
}
