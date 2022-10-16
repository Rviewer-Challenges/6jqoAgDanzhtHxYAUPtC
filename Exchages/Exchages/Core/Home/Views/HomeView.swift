//
//  HomeView.swift
//  Exchages
//
//  Created by Dario Gallegos on 13/10/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPorfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                homeHeader
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}


extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButton(iconName: showPorfolio ? "plus" : "info")
                .animation(.none, value: showPorfolio)
                .background {
                    CircleButtonAnimation(animated: $showPorfolio)
                        .frame(width: 70, height: 70)
                }
            Spacer()
            
            Text(showPorfolio ? "Porfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: showPorfolio)
            
            Spacer()
            
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPorfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPorfolio.toggle()
                    }
                }
         }
        .padding(.horizontal)
    }
}
