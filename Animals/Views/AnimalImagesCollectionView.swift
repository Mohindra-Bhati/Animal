//
//  AnimalImagesCollectionView.swift
//  Animals
//
//  Created by Mohindra Bhati on 08/07/24.
//

import SwiftUI

struct AnimalImagesCollectionView: View {
    @Environment(\.presentationMode) private var mode
    @StateObject private var viewModel = AnimalImagesViewModel()
    var animal: AnimalModel
    var category: AnimalCategoryModel

    var body: some View {
        HStack {
            Button(action: {
                mode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .tint(.blue)
                    .padding()
                    .frame(width: 70, height: 90)
                    .overlay(RoundedRectangle(cornerRadius: 25.0).stroke().opacity(0.3))
                    .foregroundColor(.red.opacity(0.9))
            }
            
            Spacer()
            Text("Images For **\(category.name ?? "")**")
                .font(.system(size: 36))
                .padding(.leading)
        }
        .padding()
                
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.photoList, id: \.id) { photo in
                    AnimalImageView(animal: animal, photo: photo)
                }
            }
            .padding(.trailing, 30)
        }
        .onAppear {
            viewModel.fetchAnimalImages(category.name ?? "")
        }
        .refreshable {
            viewModel.fetchAnimalImages(category.name ?? "")
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AnimalImageView: View {
    var animal: AnimalModel
    var photo: Photo
    var body: some View {
        
        ZStack {
            Image(animal.image).opacity(0.8)
            AsyncImage(url: URL(string: photo.src?.medium ?? "")!)
                .frame(width: 170, height: 215)
                .scaledToFill()

            Text(photo.photographer ?? "")
                .lineLimit(nil)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(.top, 150)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 150, alignment: .leading)
            
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(.red.opacity(0.9))
                .padding(.leading, 120)
                .padding(.bottom, 150)
                .fixedSize()
                .onTapGesture {
                    print("Button Pressed!")
                    StorageManager.shared.savePhoto(animal: animal, photo: photo)
                }
            
//            Button(action: {
//                
//                StorageManager.shared.savePhoto(animal: animal, photo: photo)
//            }) {
//               
//            }
        }
        .fixedSize()
        .padding()
        .frame(width: 170, height: 215)
        .background(animal.color.opacity(0.3))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.leading, 30)
        
    }
    
}
