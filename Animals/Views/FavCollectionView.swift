//
//  FavCollectionView.swift
//  Animals
//
//  Created by Mohindra Bhati on 10/07/24.
//

import SwiftUI

struct FavCollectionView: View {
    @Environment(\.presentationMode) var mode
    @StateObject var viewModel = FavCollectionViewModel()
    @State private var showToast = false
    
    @State var selectedFilter = "All"

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
                Text("Saved Animal Images")
                    .font(.system(size: UIConstants.titleFontSize))
                    .padding(.leading)
            }
            .padding()
            .overlay(
                VStack {
                    if showToast {
                        ToastView(message: "Image Deleted from favorites successfully.")
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .zIndex(1)
                    }
                    Spacer()
                }
            )
            FilterView
            .padding()
            
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(0..<viewModel.filterdAnimalList.count, id: \.self) { index in
                            let obj = viewModel.filterdAnimalList[index]
                            FavAnimalImageView(viewModel: viewModel, photo: obj, index: index, filter: selectedFilter, showToast: $showToast)
                        }
                    }
                    .padding(.trailing, 30)
                }
                .navigationBarBackButtonHidden(true)
                Image("no-pictures")
                    .opacity(0.5)
                    .hidden(viewModel.isPhotoAvailable)
            }
        }
    }
    
    
    var FilterView: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(viewModel.filterList, id: \.id) { animal in
                        Button {
                            selectedFilter = animal.name
                            viewModel.updateUIwithFilter(name: selectedFilter)
                            
                        } label: {
                            HStack {
                                if animal.name != "All" {
                                    Image(animal.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIConstants.iconWidth, height: UIConstants.iconHeight)
                                        .foregroundColor(selectedFilter == animal.name ? .yellow : .black)
                                        
                                }
                                Text(animal.name)
                            }
                            .padding()
                            .background(selectedFilter == animal.name ? .black : .gray.opacity(0.1) )
                            .foregroundColor(selectedFilter == animal.name ? .yellow : .black)
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .onAppear {
                viewModel.updateUIwithFilter(name: selectedFilter)
            }
        }
    }
}

