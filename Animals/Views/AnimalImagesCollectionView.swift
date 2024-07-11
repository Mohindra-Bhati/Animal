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
    @State private var showToast = false
    
    var animal: AnimalModel
    var category: AnimalCategoryModel

    var body: some View {
        Group {
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
            .overlay(
                VStack {
                    if showToast {
                        ToastView(message: "Image Added in favorites successfully.")
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .zIndex(1)
                    }
                    Spacer()
                }
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.photoList, id: \.id) { photo in
                        AnimalImageView(animal: animal, photo: photo, showToast: $showToast)
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
}

struct AnimalImageView: View {
    var animal: AnimalModel
    var photo: Photo
    @Binding var showToast: Bool
    var body: some View {
        
        ZStack {
            Image(animal.image).opacity(0.8)
            AsyncImage(url: URL(string: photo.src?.medium ?? "")!)
                .frame(width: 170, height: 215)
                .aspectRatio(contentMode: .fill)
                .clipped()

            Text(photo.photographer ?? "")
                .lineLimit(nil)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(.top, 150)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 150, alignment: .leading)
            
            Button(action: {
                showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showToast = false
                    }
                }
                StorageManager.shared.savePhoto(animal: animal, photo: photo)
            }) {
               Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(.red.opacity(0.9))
                .padding(.leading, 120)
                .padding(.bottom, 150)
                .fixedSize()
            }
        }
        .fixedSize()
        .padding()
        .frame(width: 170, height: 215)
        .background(animal.color.opacity(0.3))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.leading, 30)
    }
}




