//
//  CoinImageViewModel.swift
//  Exchages
//
//  Created by Dario Gallegos on 19/10/22.
//

import UIKit
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let imageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        self.isLoading = true
        addSubscribers()
    }
    
    private func addSubscribers () {
        imageService.$image
            .sink(receiveCompletion: { [weak self] (_) in
                self?.isLoading = false
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            })
            .store(in: &cancellables)
    }
}
