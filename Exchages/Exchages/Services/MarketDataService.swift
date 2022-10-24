//
//  MarketDataService.swift
//  Exchages
//
//  Created by Dario Gallegos on 23/10/22.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel?
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {

        guard let url = URL(string: Constants.urlApiGeeko + "/global") else {
            return
        }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData .self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
