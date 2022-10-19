//
//  CoinImageService.swift
//  Exchages
//
//  Created by Dario Gallegos on 19/10/22.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    private var imageSubsciption: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        
        guard let url = URL(string: coin.image) else {
            return
        }
        
        imageSubsciption = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubsciption?.cancel()
            })
    }
}
