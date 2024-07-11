//
//  HomeViewModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    var animalList = [
        AnimalModel(name: "Elephant", category: "Wild", image: "elephant", color: .pink , price: 8),
        AnimalModel(name: "Lion", category: "Wild", image: "lion", color: .yellow , price: 8),
        AnimalModel(name: "Fox", category: "Wild", image: "fox", color: .red , price: 8),
        AnimalModel(name: "Dog", category: "Wild", image: "dog", color: .green , price: 8),
        AnimalModel(name: "Shark", category: "Marine", image: "shark", color: .blue , price: 8),
        AnimalModel(name: "Turtle", category: "Marine", image: "turtle", color: .brown , price: 8),
        AnimalModel(name: "Whale", category: "Marine", image: "whale", color: .orange , price: 8),
        AnimalModel(name: "Penguin", category: "Bird", image: "penguin", color: .purple , price: 8)
    ]
        
    var categoryList: [CategoryModel] = [
        CategoryModel(icon: "", title: "All"),
        CategoryModel(icon: "wild", title: "Wild"),
        CategoryModel(icon: "marine", title: "Marine"),
        CategoryModel(icon: "bird", title: "Bird"),
        
    ]
    
    @Published var filterdAnimalList: [AnimalModel] = []
    
    func updateUIwithFilter(name: String) {
        if name == "All" {
            filterdAnimalList = animalList
        } else {
            filterdAnimalList = animalList.filter({$0.category == name})
        }
    }
    
}
