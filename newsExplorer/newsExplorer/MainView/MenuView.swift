//
//  MenuView.swift
//  

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: MainViewModel
    var body: some View {
        Menu {
            Button("Sort by popularity", role: .none) {
                viewModel.items = []
                viewModel.request(endpoint: .bitcoinPopularityEndpoint)
            }
            Button("Sort by relevancy", role: .none) {
                viewModel.items = []
                viewModel.request(endpoint: .bitcoinRelevancyEndpoint)
            }
            
            Button("Sort by publishedAt", role: .none) {
                viewModel.items = []
                viewModel.request(endpoint: .bitcoinPublishedAtEndpoint)
            }
            
            Button("Cancel", role: .destructive) {   
            }
            
        } label: {
            Image("popUp")
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: MainViewModel())
    }
}
