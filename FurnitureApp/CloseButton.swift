//
//  CloseButton.swift
//  MultiPlatformCourse (iOS)
//
//  Created by Anselm Jade Jamig on 5/24/21.
//

import SwiftUI

struct CloseButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.black.opacity(0.7))
            .padding(.all, 10)
            .background(Color.white.opacity(0.6))
            .clipShape(Circle())
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
