//
//  HomeView.swift
//  Exchages
//
//  Created by Dario Gallegos on 13/10/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPorfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                homeHeader
                SearchBar(searchText: $viewModel.searchText)
                columnTitles
                
                if !showPorfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPorfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden, for: .navigationBar)
        }
        .environmentObject(dev.homeViewModel)
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
        .padding(.bottom)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin , showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin , showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPorfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
}
