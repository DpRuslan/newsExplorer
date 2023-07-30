//
//  CellView.swift
//

import SwiftUI

struct CellView: View {
    var item: ArticleWrapper
    
    var body: some View {
        ZStack {
            Color(UIColor.lightGray.withAlphaComponent(0.5))
                .cornerRadius(10)
            VStack(alignment: .center, spacing: 8) {
                Text(item.article.title ?? "None")
                    .font(Font.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(0)
                
                Text(item.article.description ?? "None")
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5))
            }
        
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: DetailView(item: item)) {
                EmptyView()
            }
            .opacity(0)
        }
    }
}
