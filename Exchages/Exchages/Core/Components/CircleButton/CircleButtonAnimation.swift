//
//  CircleButtonAnimation.swift
//  Exchages
//
//  Created by Dario Gallegos on 13/10/22.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animated: Bool
    
    var body: some View {
        Circle()
            .stroke(style: .init(lineWidth: 5.0))
            .scale(animated ? 1 : 0)
            .opacity(animated ?  0 : 1)
            .animation(animated ? .easeOut(duration: 0.8) : .none, value: animated)
    }
}

struct CircleButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimation(animated: .constant(true))
    }
}
