//
//  ListView.swift
//  Animals
//
//  Created by Mohindra Bhati on 09/07/24.
//

import SwiftUI
import Combine

struct AnimalCategoryListView: View {
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel = AnimalCategoryViewModel()
    
    var animal: AnimalModel
    
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
            Text("Please select an **Animal Category**")
                .font(.system(size: 32))
                .padding(.leading)
        }
        .padding()
        
        NavigationView {
            List(viewModel.categoryList , id: \.name) { category in
                NavigationLink(destination: AnimalImagesCollectionView(animal: animal, category: category)) {
                    ListItemView(animal: category)
                }
                .listRowSeparator(.hidden)
            
            }
            .onAppear {
                viewModel.fetchAnimalCategory(animal.name)
            }
            .refreshable {
                viewModel.fetchAnimalCategory(animal.name)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct ListItemView: View {
    var animal: AnimalCategoryModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(animal.name ?? "Unknown")
                    .font(.system(size: 18))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .frame(width: 300, height: 80)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
        }
    }
}
