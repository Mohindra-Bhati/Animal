//
//  AnimalImageView.swift
//  Animals
//
//  Created by Mohindra Bhati on 11/07/24.
//

import SwiftUI

struct AnimalImageView: View {
    var animal: AnimalModel
    var photo: Photo
    @Binding var showToast: Bool
    var body: some View {
        if let url = URL(string: photo.src?.medium ?? "") {
            ZStack {
                AsyncImage(
                    url: url,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
                VStack {
                    Spacer()
                    Text(photo.photographer ?? "")
                        .lineLimit(nil)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: UIConstants.cellWidth - 20 , alignment: .leading)
                        .padding()
                }
                
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
                            StorageManager.shared.savePhoto(animal: animal, photo: photo)
                        }) {
                            Text("Save")
                                .frame(width: 80, height: 40)
                                .foregroundColor(.white)
                                .background(Color.pink)
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
            .background(.gray)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.leading, 30)
        }
    }
}
