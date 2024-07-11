//
//  AnimalImagesViewModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import Foundation
import Combine

class AnimalImagesViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let serviceProvider = NetworkServiceProvider()
    @Published var photoListModel: PhotoListModel?
    @Published var photoList: [Photo] = []
    
    func fetchAnimalImages(_ name: String) {
        var request = AnimalImageListRequest()
        request.queryParameters = ["per_page": "100",
                                   "query": name]
        serviceProvider.fetch(request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { model in
                self.photoListModel = model
                self.photoList = self.photoListModel?.photos ?? []
            }
            .store(in: &cancellables)
    }
}
