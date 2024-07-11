//
//  Home.swift
//  Animals
//
//  Created by Mohindra Bhati on 08/07/24.
//

import SwiftUI

struct Home: View {
    @State var selectedCategory = "All"
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Please select an **Animal**")
                            .font(.system(size: 32))
                            .padding(.leading)
                        
                        Spacer()
                        NavigationLink {
                            FavCollectionView()
                        } label: {
                            
                            Image(systemName: "heart.fill")
                                .imageScale(.large)
                                .tint(.blue)
                                .padding()
                                .frame(width: 70, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke().opacity(0.3))
                                .foregroundColor(.red.opacity(0.9))
                        }
                        
                        
                    }
                }
                .padding()
                categoryListView
                
                HStack {
                    Text("**Animal List**")
                        .font(.system(size: 24))
                    Spacer()
                }
                .padding(.vertical)
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(viewModel.filterdAnimalList, id: \.id) { item in
                            ProductView(animal: item)
                        }
                    }

                }
                .padding(.trailing)
            }
            .onAppear {
                viewModel.updateUIwithFilter(name: selectedCategory)
            }
        }
    }
    
    var categoryListView: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(viewModel.categoryList, id: \.id) { item in
                        Button {
                            selectedCategory = item.title
                            viewModel.updateUIwithFilter(name: selectedCategory)
                            
                        } label: {
                            HStack {
                                if item.title != "All" {
                                    Image(item.icon)
                                        .foregroundColor(selectedCategory == item.title ? .yellow : .black)
                                }
                                Text(item.title)
                            }
                            .padding()
                            .background(selectedCategory == item.title ? .black : .gray.opacity(0.1) )
                            .foregroundColor(selectedCategory == item.title ? .yellow : .black)
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    Home()
}

struct ProductView: View {
    var animal: AnimalModel
    var body: some View {
        
        ZStack {
            ZStack {
                Image("\(animal.image)")
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading, content: {
                    Text("\(animal.name)")
                        .font(.system(size: 36, weight: .semibold))
                    
                    Text("\(animal.category)")
                        .font(.system(size: 25))
                        .padding()
                        .background(.white.opacity(0.5))
                        .clipShape(Capsule())
                    Spacer()
                    
                    NavigationLink {
                        AnimalCategoryListView(animal: animal)
                    } label: {
                        Text("View More")
                            .font(.system(size: 17))
                            .padding()
                            .background(.white.opacity(0.5))
                            .clipShape(Capsule())
                            .foregroundColor(.black)
                    }
                })
                .padding(.trailing, 100)
            }
            .padding()
            .frame(width: 280, height: 390)
            .background(animal.color.opacity(0.3))
            .clipShape(.rect(cornerRadius: 30))
            .padding(.leading, 30)
            
            
        }
    }
}
