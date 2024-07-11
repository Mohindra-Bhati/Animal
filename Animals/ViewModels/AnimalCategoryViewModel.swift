//
//  AnimalCategoryViewModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 09/07/24.
//

import Foundation
import Combine

class AnimalCategoryViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let serviceProvider = NetworkServiceProvider()
    @Published var categoryList: [AnimalCategoryModel] = []
    
    func fetchAnimalCategory(_ animal: String) {
        var request = AnimalCategoryRequest()
        request.queryParameters = ["name": animal]
        serviceProvider.fetch(request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { categoryList in
                self.categoryList = categoryList
            }
            .store(in: &cancellables)
    }
}
