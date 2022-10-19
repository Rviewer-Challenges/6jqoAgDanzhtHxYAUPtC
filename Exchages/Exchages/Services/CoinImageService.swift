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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let loadedImage = fileManager.loadImage(imageName: imageName, folderName: folderName) {
            image =  loadedImage
        }
        else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        
        guard let url = URL(string: coin.image) else {
            return
        }
        
        imageSubsciption = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubsciption?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
