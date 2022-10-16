//
//  CircleButton.swift
//  Exchages
//
//  Created by Dario Gallegos on 13/10/22.
//

import SwiftUI

struct CircleButton: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.25),
                    radius: 10)
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(iconName: "heart.fill")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
