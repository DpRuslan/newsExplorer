//
//  DetailViewModel.swift
//

import Foundation
import SwiftUI

enum DetailInfo: Identifiable {
    var id: UUID {
        UUID()
    }
    case title(value: String)
    case description(value: String)
    case author(value: String)
    case source(value: String)
    case publishedAt(value: String)
}

class DetailViewModel: ObservableObject {
    @Published var loadedImage: Image?
    let placeholderImage = Model.placeholderImage
    var item: ArticleWrapper
    var dataSource: [DetailInfo] = []
    
    init(item: ArticleWrapper) {
        self.item = item
        loadImageFromUrl()
        setDataSource()
    }
    
    func setDataSource() {
        dataSource = [
            .title(value: item.article.title ?? "None" ),
            .description(value: item.article.description ?? "None"),
            .author(value: item.article.author ?? "None"),
            .source(value: item.article.source.name ?? "None"),
            .publishedAt(value: publishedAtFormatter())
        ]
    }
    
    func publishedAtFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: item.article.publishedAt ?? "None") {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        } else {
            return "None"
        }
    }
    
    func loadImageFromUrl() {
        guard let urlToImage = item.article.urlToImage,
              let urlFromString = URL(string: urlToImage) else { loadedImage = placeholderImage
            return
        }
        
        URLSession.shared.dataTask(with: urlFromString) { [weak self] data, _,  error in
            guard let data = data,
                  let image = UIImage(data: data) else {
                if let _ = error {
                    self?.loadedImage = self!.placeholderImage
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self?.loadedImage = Image(uiImage: image)
            }
        }.resume()
    }
}

extension DetailInfo {
    var cellTitle: String {
        switch self {
        case .title(_):
            return "Title"
        case .description(_):
            return "Description"
        case .author(_):
            return "Author"
        case .source(_):
            return "Source"
        case .publishedAt(_):
            return "Published At"
        }
    }
    
    var cellValue: String {
        switch self {
        case .title(let value):
            return value
        case .description(let value):
            return value
        case .author(let value):
            return value
        case .source(let value):
            return value
        case .publishedAt(let value):
            return value
        }
    }
}
