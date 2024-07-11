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
                        .frame(width: UIConstants.navigationIconWidth, height: UIConstants.navigationIconHeight)
                        .overlay(RoundedRectangle(cornerRadius: 25.0).stroke().opacity(0.3))
                        .foregroundColor(.red.opacity(0.9))
                }
                
                Spacer()
                Text("Images For **\(category.name ?? "")**")
                    .font(.system(size: UIConstants.titleFontSize))
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
