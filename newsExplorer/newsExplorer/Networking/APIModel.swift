//
//  APIModel.swift
//

import Foundation

struct Response: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Decodable {
    let name: String?
}

struct ArticleWrapper: Identifiable, Hashable {
    static func == (lhs: ArticleWrapper, rhs: ArticleWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    let article: Article
}
