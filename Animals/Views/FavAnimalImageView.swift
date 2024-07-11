//
//  FavAnimalImageView.swift
//  Animals
//
//  Created by Mohindra Bhati on 11/07/24.
//

import SwiftUI

struct FavAnimalImageView: View {
    let viewModel: FavCollectionViewModel
    let photo: PhotoData
    let index: Int
    let filter: String
    @Binding var showToast: Bool
    
    var body: some View {
        if let url = URL(string: photo.photo ?? "") {
        ZStack {
            AsyncImage(
                url: url,
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: UIConstants.cellWidth, maxHeight: UIConstants.cellHeight)
                },
                placeholder: {
                    ProgressView()
                }
            )
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showToast = false
                            }
                        }
                        viewModel.deletePhoto(photo: photo,filter: filter)
                    }) {
                        Text("Delete")
                            .padding()
                            .imageScale(.large)
                            .foregroundColor(.red)
                            .background(Color.white)
                            .fixedSize()
                    }
                    .clipShape(Capsule())
                    Spacer()
                }
            }
            .padding()
        }
            .fixedSize()
            .padding()
            .frame(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
            .clipShape(.rect(cornerRadius: 30))
        }
    }
}

