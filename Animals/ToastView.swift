//
//  ToastView.swift
//  Animals
//
//  Created by Mohindra Bhati on 11/07/24.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .foregroundColor(.black)
            .padding()
            .background(.yellow.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
    }
}

