//
//  APIManager.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: SessionManager {
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 40
        
        super.init(configuration: configuration)
        self.adapter = AuthRequestAdapter()
    }
}

/**
 
 AuthRequestAdapter is subclass of RequestAdapter. It checks each request. If request is login or register we dont need extra headers in request. In all other cases we add token
 */
class AuthRequestAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if (urlRequest.url!.lastPathComponent != "register") &&
            (urlRequest.url!.lastPathComponent != "api-token-auth") {
            urlRequest.addValue("Token " + Keychain.shared[Constants.Keychain.token]!, forHTTPHeaderField:Constants.API.Headers.authorization)
        }
        //urlRequest.addValue(Constants.API.Headers.applicationJson, forHTTPHeaderField:Constants.API.Headers.contentType)
        return urlRequest
    }
}
