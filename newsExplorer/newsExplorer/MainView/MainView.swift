//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(3)
                }
                
            } else {
                List {
                    ForEach(viewModel.items) { item in
                        CellView(item: item)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .navigationTitle("News Explorer")
                .toolbar {
                    MenuView(viewModel: viewModel)
                }
                
                .listStyle(.grouped)
                
                .scrollContentBackground(.hidden)
                .padding(.top, 90)
            }
            
        }
        .onAppear() {
            viewModel.request(endpoint: .bitcoinEndpoint)
        }
        
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.error!), dismissButton: .default(Text("Got it!")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
