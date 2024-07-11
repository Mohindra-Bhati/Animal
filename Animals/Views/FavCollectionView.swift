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
    
    @State var selectedFilter = "All"

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
            Text("Saved Animal Images")
                .font(.system(size: 36))
                .padding(.leading)
        }
        .padding()
        
        FilterView
        .padding()
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.filterdAnimalList, id: \.id) { obj in
                        FavAnimalImageView(photo: obj, filter: selectedFilter)
                    }
                }
                .padding(.trailing, 30)
            }
            .refreshable {
                viewModel.updateUIwithFilter(name: selectedFilter)
            }
            .navigationBarBackButtonHidden(true)
            Image("no-pictures")
                .opacity(0.5)
                .hidden(viewModel.isPhotoAvailable)
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
                                        .frame(width: 40, height: 40)
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

//#Preview {
//    FavCollectionView()
//}

struct FavAnimalImageView: View {
    @StateObject var viewModel = FavCollectionViewModel()
    var photo: PhotoData
    var filter: String
    var body: some View {
        if let url = URL(string: photo.photo ?? "") {
            ZStack {
                AsyncImage(url: url)
                Image("trash-bin")
                    .imageScale(.large)
                    .foregroundColor(.red.opacity(0.9))
                    .padding(.leading, 120)
                    .padding(.bottom, 150)
                    .fixedSize()
                    .onTapGesture {
                        viewModel.deletePhoto(photo: photo, filter: filter)
                    }
            }
            .fixedSize()
            .padding()
            .frame(width: 170, height: 215)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.leading, 30)
        }
    }
}
