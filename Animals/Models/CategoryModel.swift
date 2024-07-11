//
//  CategoryModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 08/07/24.
//

import SwiftUI

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}
