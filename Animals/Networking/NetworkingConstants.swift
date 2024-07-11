//
//  NetworkingConstants.swift
//  Animals
//
//  Created by Mohindra Bhati on 04/07/24.
//

import Foundation

enum AppConstants {
    static var apiKey: String { return try! Configuration.value(for: "API_KEY")}
    static var authKey: String { return try! Configuration.value(for: "AUTH_KEY")}
}

enum API{
    case animals
    case imageList

    var path: String{
        switch self {
        case .animals:
            "https://api.api-ninjas.com/v1/animals?"
        case .imageList:
            "https://api.pexels.com/v1/search?"
        }
    }
    
}

enum EndPoints {
    static var animalList: String {
        return "animals"
    }
    
}
