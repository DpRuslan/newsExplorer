//
//  Extension.swift
//

import Foundation

extension String {
    static let baseURL = "https://newsapi.org/v2"
    static let apiKey = "2fd66d8167044cb182ba107fbdde50fb"
    static let bitcoinEndpoint = "/everything?q=bitcoin"
    static let bitcoinPublishedAtEndpoint = "/everything?q=bitcoin&sortBy=publishedAt"
    static let bitcoinPopularityEndpoint = "/everything?q=bitcoin&sortBy=popularity"
    static let bitcoinRelevancyEndpoint = "/everything?q=bitcoin&sortBy=relevancy"
}
