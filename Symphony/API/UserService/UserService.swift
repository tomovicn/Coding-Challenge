//
//  UserService.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UserService {
    let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func register(user: User, succes: @escaping (_ user: User) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(UserRouter.register(user: user)).validate().responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success(let user):
                succes(user)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func login(user: User, succes: @escaping (_ token: String) -> Void, failure : @escaping ((String) -> Void)) {
        apiManager.request(UserRouter.login(user: user)).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let JSON = response.result.value as? NSDictionary {
                    if let token = JSON[Constants.Keys.User.token] as? String {
                        UserDefaults.standard.set(token, forKey: Constants.UserDefaults.token)
                        succes(token)
                    }
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
}
