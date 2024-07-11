//
//  FavCollectionViewModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import Foundation

class FavCollectionViewModel: ObservableObject {
    var filterList = [
        AnimalModel(name: "All", category: "wild", image: "", color: .pink , price: 8),
        AnimalModel(name: "Elephant", category: "wild", image: "elephant", color: .pink , price: 8),
        AnimalModel(name: "Lion", category: "wild", image: "lion", color: .yellow , price: 8),
        AnimalModel(name: "Fox", category: "wild", image: "fox", color: .red , price: 8),
        AnimalModel(name: "Dog", category: "wild", image: "dog", color: .green , price: 8),
        AnimalModel(name: "Shark", category: "marine", image: "shark", color: .blue , price: 8),
        AnimalModel(name: "Turtle", category: "marine", image: "turtle", color: .brown , price: 8),
        AnimalModel(name: "Whale", category: "marine", image: "whale", color: .orange , price: 8),
        AnimalModel(name: "Penguin", category: "bird", image: "penguin", color: .purple , price: 8)
    ]
    
    @Published var filterdAnimalList: [PhotoData] = []
    @Published var isPhotoAvailable: Bool = false
    
    func updateUIwithFilter(name: String) {
        if name == "All" {
            filterdAnimalList = StorageManager.shared.getPhotosData() ?? []
        } else {
            filterdAnimalList = StorageManager.shared.filterPhotos(byCategory: name) ?? []
        }
        isPhotoAvailable =  filterdAnimalList.isEmpty ? false : true
    }
    
    
    
    func deletePhoto(photo: PhotoData, filter: String){
        StorageManager.shared.deletePhoto(photoData: photo)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.updateUIwithFilter(name: filter)
        })
    }
}
