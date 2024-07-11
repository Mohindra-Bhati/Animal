//
//  AnimalCategoryRequest.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import Foundation
struct AnimalCategoryRequest: ApiRequest {
    
    var queryParameters: [String : String]?
    
    var url: URL {
        return URL(string: "\(API.animals.path)")!
    }
    
    var method: String {
        return "GET"
    }
}
