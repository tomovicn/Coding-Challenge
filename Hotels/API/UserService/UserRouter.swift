//
//  UserRouter.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Alamofire

enum UserRouter: URLRequestConvertible {
    
    case register(user: User, password: String)
    case login(user: User, password: String)
    
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    var path: String {
        
        switch self {
        case .register:
            return Constants.API.Endpoints.User.register
        case .login:
            return Constants.API.Endpoints.User.login
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .register(let user, let password):
            return [Constants.API.Parameters.firstname : user.firstName!, Constants.API.Parameters.lastname : user.lastName!, Constants.API.Parameters.email : user.email!, Constants.API.Parameters.username : user.username!, Constants.API.Parameters.password : password]
        case .login(let user, let password):
            return [Constants.API.Parameters.username : user.username!, Constants.API.Parameters.password : password]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.Endpoints.baseUrl.asURL()
        
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        return urlRequest
    }
}
