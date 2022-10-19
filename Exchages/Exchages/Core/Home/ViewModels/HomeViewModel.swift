//
//  HomeViewModel.swift
//  Exchages
//
//  Created by Dario Gallegos on 17/10/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
            }
            .store(in: &cancellables)
    }
}
