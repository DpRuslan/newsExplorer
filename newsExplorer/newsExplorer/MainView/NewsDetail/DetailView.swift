//
//  DetailView.swift
//

import SwiftUI

struct DetailView: View {
    var item: ArticleWrapper
    @StateObject private var viewModel: DetailViewModel
    
    init(item: ArticleWrapper) {
        self.item = item
        _viewModel = StateObject(wrappedValue: DetailViewModel(item: item))
    }
    
    var body: some View {
        VStack {
            ZStack {
                if viewModel.loadedImage == nil {
                    Color.gray.opacity(0.3)
                    ProgressView()
                        .scaleEffect(2)
                } else {
                    viewModel.loadedImage!
                        .resizable()
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .frame(height: UIScreen.main.bounds.size.height/2.7, alignment: .top)
                }
            }
            
            .cornerRadius(8)
            .padding(.horizontal, 20)
            .frame(height: UIScreen.main.bounds.size.height/2.7, alignment: .top)
            
            List {
                ForEach(viewModel.dataSource) { param in
                    VStack(alignment: .center) {
                        Text(param.cellTitle)
                            .font(Font.system(size: 17, weight: .bold))
                            .multilineTextAlignment(.center)
                        Text(param.cellValue)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
                }
            }
            .padding(.top, -10)
            .scrollContentBackground(.hidden)
            .listStyle(.grouped)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadImageFromUrl()
        }
    }
}

