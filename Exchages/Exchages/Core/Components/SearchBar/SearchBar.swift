//
//  SearchBar.swift
//  Exchages
//
//  Created by Dario Gallegos on 20/10/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? .theme.secondaryText : .theme.accent
                )
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled()
            
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.theme.accent)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .padding(14)
                .offset(x: 8)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.1), radius: 8)
        )
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
