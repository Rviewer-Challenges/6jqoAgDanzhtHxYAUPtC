//
//  CoinService.swift
//  Exchages
//
//  Created by Dario Gallegos on 17/10/22.
//

import Foundation
import Combine

class CoinService {
    
    @Published var allCoins:[CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        
        
        guard let url = URL(string: Constants.urlApiGeeko + "/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }) 
    }
}
