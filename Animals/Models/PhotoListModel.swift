//
//  PhotoListModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import Foundation

struct PhotoListModel: Codable {
        let page: Int?
        let perPage: Int?
        let photos: [Photo]?
        let totalResults: Int?
        let nextPage: String?

        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case photos
            case totalResults = "total_results"
            case nextPage = "next_page"
        }
    }

    struct Photo: Codable, Identifiable {
        let id: Int?
        let width: Int?
        let height: Int?
        let url: String?
        let photographer: String?
        let photographerURL: String?
        let photographerID: Int?
        let avgColor: String?
        let src: PhotoSrc?
        let liked: Bool?
        let alt: String?

        enum CodingKeys: String, CodingKey {
            case id
            case width
            case height
            case url
            case photographer
            case photographerURL = "photographer_url"
            case photographerID = "photographer_id"
            case avgColor = "avg_color"
            case src
            case liked
            case alt
        }
    }

    struct PhotoSrc: Codable {
        let original: String?
        let large2x: String?
        let large: String?
        let medium: String?
        let small: String?
        let portrait: String?
        let landscape: String?
        let tiny: String?
    }

