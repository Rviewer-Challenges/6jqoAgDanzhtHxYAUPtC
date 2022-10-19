//
//  CoinImage.swift
//  Exchages
//
//  Created by Dario Gallegos on 19/10/22.
//

import SwiftUI

struct CoinImage: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                 Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if viewModel.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct CoinImage_Previews: PreviewProvider {
    static var previews: some View {
        CoinImage(coin: dev.coin)
    }
}
