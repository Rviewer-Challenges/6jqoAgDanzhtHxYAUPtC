//
//  HomeStatsView.swift
//  Exchages
//
//  Created by Dario Gallegos on 22/10/22.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var showPorfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPorfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPorfolio: .constant(false))
            .environmentObject(dev.homeViewModel)
    }
}
