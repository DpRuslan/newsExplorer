//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedOption = 0
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(3)
                }
            } else {
                VStack {
                    Picker("", selection: $selectedOption) {
                        Text("Search by word").tag(0)
                        Text("Search by period").tag(1)
                    }
            
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
                    
                }
                
                .padding(.top, 10)
                .searchable(text: $searchText, prompt: selectedOption == 0 ? "news" : "2023-07-01 : 2023-07-15")
                .padding(.top, -10)
                
                
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
                .padding(.top, 0)
            }
        }
        
        .onSubmit(of: .search) {
            if selectedOption == 0 {
                viewModel.request(endpoint: .wordEndpoint+searchText)
            } else {
                viewModel.checksForPeriod(searchText: searchText)
            }
            
            searchText = ""
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
