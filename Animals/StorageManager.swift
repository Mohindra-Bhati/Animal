//
//  StorageManager.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import Foundation
import CoreData

class StorageManager {
    private init() {}
    static let shared = StorageManager()
    private let context = CoreDataStack.shared.context
    
    func savePhoto(animal: AnimalModel, photo: Photo) {
        let entity = PhotoData(context: context)
        entity.id = UUID()
        entity.photo = photo.src?.medium
        entity.category = animal.name
        entity.photographer = photo.photographer
        do {
            try context.save()
        } catch {
            print("Error in saving photo data", error)
        }
    }
    
    func getPhotosData() -> [PhotoData]? {
        do {
            let data = try context.fetch(PhotoData.fetchRequest())
            return data.count > 0 ? data : nil
        } catch {
            print("Error in fetching photo data", error)
            return nil
        }
    }
    
    func deletePhoto(photoData: PhotoData) {
        context.delete(photoData)
        do {
            try context.save()
        } catch {
            print("Error in deleting photo data", error)
        }
    }
    
    func filterPhotos(byCategory category: String) -> [PhotoData]? {
        let fetchRequest: NSFetchRequest<PhotoData> = PhotoData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        do {
            let filteredData = try context.fetch(fetchRequest)
            return filteredData.count > 0 ? filteredData : nil
        } catch {
            print("Error in fetching filtered photo data", error)
            return nil
        }
    }
}

