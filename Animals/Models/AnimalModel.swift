//
//  AnimalList.swift
//  Animals
//
//  Created by Mohindra Bhati on 08/07/24.
//

import SwiftUI

struct AnimalModel: Identifiable {
    var id: UUID = .init()
    var name: String
    var category: String
    var image: String
    var color: Color
    var price: Int
}


