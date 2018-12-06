//
//  NetworkWrapper.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 04/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import UIKit

class NetworkWrapper: NSObject {
    
    class func makePostRequest(url:String,params: [String: Any] ,sucess: @escaping(( _ response: Data) -> Void),failure:  @escaping(( _ errMessage: String) -> Void)) {
        
        guard let urrl = URL(string: url) else {
            failure("Some server error occured")
            return
        }
        var urlRequest = URLRequest(url: urrl)
        urlRequest.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            print("Error: cannot create request")
            return
        }
        urlRequest.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                failure("Some server error occured")
                return
            }
            if httpResponse.statusCode == 200 {
                if error == nil {
                    if let responseData = data {
                        sucess(responseData)
                    }
                } else {
                    failure(error?.localizedDescription ?? "")
                }
            } else {
                failure("Some server error occured")
            }
        }
        task.resume()
    }
}
