//
//  View+Extension.swift
//  Animals
//
//  Created by Mohindra Bhati on 11/07/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}

