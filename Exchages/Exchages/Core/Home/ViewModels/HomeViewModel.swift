//
//  HomeViewModel.swift
//  Exchages
//
//  Created by Dario Gallegos on 17/10/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
     
    let statistics: [StatisticModel] = [
        StatisticModel(title: "Title1", value: "Value", percentage: 1),
        StatisticModel(title: "Title2", value: "Value"),
        StatisticModel(title: "Title3", value: "Value"),
        StatisticModel(title: "Title4", value: "Value", percentage: -7)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //Update all coins mathcing searchText and coin list
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter {
            $0.name.lowercased().contains(lowercasedText) ||
            $0.symbol.lowercased().contains(lowercasedText) ||
            $0.id.lowercased().contains(lowercasedText)
        }
    }
}
